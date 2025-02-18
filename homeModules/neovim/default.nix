{
  lib,
  pkgs,
  config,
  inputs,
  meta,
  ...
}:
# Stolen from @NTBBloodbath/tundra
let
  binpath = lib.makeBinPath (
    with pkgs;
    [
      # LSP
      lua-language-server
      nixd
      gopls
      clang-tools
      # Typst dependencies
      typst
      tinymist
      # Formatters
      stylua
      # rocks.nvim dependencies
      lua51Packages.lua
      lua51Packages.luarocks
      # Trying to make norg parser build, doesn't work
      pkgs.tree-sitter
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      lua51Packages.rocks-dev-nvim
      luajitPackages.luarocks-build-treesitter-parser

    ]
  );
  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    extraLuaPackages = p: [
      p.magick
      p.luarocks
    ]; # I can't have rocks.nvim install it b/c that version will not find imagemagick c binary
    # Doesn't work anyways btw
    luaRcContent =
      # lua
      ''
        vim.g.nix_packdir = "${pkgs.vimUtils.packDir pkgs.neovim-stable.passthru.packpathDirs}"
        vim.cmd.source(('~/.config/%s/init.lua'):format(vim.env.NVIM_APPNAME or 'nvim'))
      '';
  };
  fullConfig = (
    neovimConfig
    // {
      wrapperArgs = lib.escapeShellArgs neovimConfig.wrapperArgs + " --prefix PATH : ${binpath}";
    }
  );
in
{
  # custom option to modulry enable and disable neovim
  options.customhm = {
    neovim.enable = lib.mkEnableOption "enable neovim";
  };
  config = lib.mkIf config.customhm.neovim.enable {
    nixpkgs.overlays = [
      (_: super: {
        neovim-stable = pkgs.wrapNeovimUnstable (super.neovim-unwrapped.overrideAttrs (oldAttrs: {
          buildInputs = oldAttrs.buildInputs ++ [ super.tree-sitter ];
        })) fullConfig;
        neovim-nightly = pkgs.wrapNeovimUnstable (
          inputs.neovim-nightly-overlay.packages.${pkgs.system}.default.overrideAttrs
          (oldAttrs: {
            buildInputs = oldAttrs.buildInputs ++ [ super.tree-sitter ];
          })
        ) fullConfig;
      })
    ];
    # so it knows where the header files are
    home.file.".local/share/nvim/rocks/luarocks-config.lua" = {
      enable = true;
      text = # lua
        ''
          lua_version = "5.1"

          rocks_trees = { {
              name = "rocks.nvim",
              root = "/home/${meta.user}/.local/share/nvim/rocks"
            } }

          variables = {
            LUA_INCDIR = "${pkgs.lua5_1}/include"
          }

          arch = "linux-x86_64"
        '';
    };
    # config for neovim
    home.file.".config/nvim" = {
      enable = true;
      recursive = true;
      source = inputs.neovim-rocks;
    };

    home.packages =
      with pkgs;
      [
        unzip # for rocks installation
        # Trying to make treesitter build norg
        # doesn't work btw
        lua51Packages.luarocks
        lua51Packages.lua
        lua51Packages.rocks-dev-nvim
        luajitPackages.luarocks-build-treesitter-parser
      ]
      ++ lib.optionals meta.isTermux [ neovim-stable ]
      ++ lib.optionals (!meta.isTermux) [ neovim-nightly ];
    # environmental vatiables to not open nano
    home.sessionVariables = lib.mkDefault {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };
  };
}
