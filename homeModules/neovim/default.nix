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
      typstyle
      # Formatters
      stylua
      # rocks.nvim dependencies
      lua51Packages.lua
      lua51Packages.luarocks
    ]
  );
  # Download treesitter binaries from nixpkgs instead of building them
  # https://www.reddit.com/r/neovim/comments/vyqcny/treesitter_uv_dlopen_libstdcso6_problem_on_wsl/
  parsers = pkgs.tree-sitter.withPlugins (_: pkgs.tree-sitter.allGrammars);
  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    extraLuaPackages = p: [
      # p.magick
      # p.luarocks
    ]; # My neovim breaks if I install anything with this list
    luaRcContent =
      # lua
      ''
        vim.opt.runtimepath:append("${parsers}")
        vim.g.nix_packdir = "${pkgs.vimUtils.packDir pkgs.neovim-nightly.passthru.packpathDirs}"
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
