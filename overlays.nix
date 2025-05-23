{
  inputs,
  lib,
  pkgs,
  meta,
  self,
  ...
}:

# Stolen from @NTBBloodbath/tundra
# the let in to define things in neovim package
let
  binpath = lib.makeBinPath (
    with pkgs;
    [
      # LSP
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
      p.magick
      # p.luarocks
    ];
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
  # basic structure
  # nixpkgs.overlays = [
  #   (_: prev: { })
  # ];

  #overlay structure stolen from @iynaix
  nixpkgs.overlays = [
    # add custom packages from ./pkgs to lists and such under a `custom` set
    (_: prev: {
      custom =
        (prev.custom or { })
        // (import ./pkgs {
          inherit (prev) pkgs;
          inherit inputs meta self;
        });
    })

    # define a pkgs.neovim overlay as packages
    # neovim stable uses pkgs.neovim
    # neovim nightly uses the github input
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
}
