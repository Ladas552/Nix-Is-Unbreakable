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
      gopls
      clang-tools
      typst
      tinymist
      lua-language-server
      nixd
      stylua
      lua51Packages.lua
      lua51Packages.luarocks
    ]
  );
  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    extraLuaPackages = p: [ p.magick ]; # I can't have rocks.nvim install it b/c that version will not find imagemagick c binary
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

    home.packages =
      with pkgs;
      [
        unzip # for rocks installation
      ]
      ++ lib.optionals meta.isTermux [ neovim-stable ]
      ++ lib.optionals (!meta.isTermux) [ neovim-nightly ];

    home.sessionVariables = lib.mkDefault {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };
  };
}
