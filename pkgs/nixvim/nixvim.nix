{
  imports = [
    # Neovim vanilla options
    ./config/autocmd.nix
    ./config/options.nix
    ./config/keymaps.nix
    ./config/colorscheme.nix
    ./config/diagnostics.nix

    # Plugins
    # Neorg module only for overlay. Don't forget to reenable overlay in flake.nix
    # ./plugins/workflow/neorg-overlay.nix
    ./plugins/cmp/luasnip.nix
    ./plugins/cmp/blink-cmp.nix
    ./plugins/workflow/auto-save.nix
    ./plugins/workflow/cord.nix
    ./plugins/workflow/direnv.nix
    ./plugins/workflow/img-clip.nix
    ./plugins/workflow/neogit.nix
    ./plugins/workflow/neorg.nix
    ./plugins/workflow/nvim-autopairs.nix
    ./plugins/workflow/oil.nix
    ./plugins/workflow/orgmode.nix
    ./plugins/workflow/otter.nix
    # ./plugins/workflow/parinfer-rust.nix
    ./plugins/workflow/snacks.nix
    ./plugins/workflow/treesitter.nix
    ./plugins/workflow/typst-preview.nix
    ./plugins/workflow/vim-nix.nix
    ./plugins/ui/colorizer.nix
    ./plugins/ui/dashboard.nix
    ./plugins/ui/heirline.nix
    ./plugins/ui/numb.nix
    ./plugins/ui/web-devicons.nix
    ./plugins/ui/which-key.nix
    ./plugins/lsp/basedpyright.nix
    ./plugins/lsp/clangd.nix
    ./plugins/lsp/conform.nix
    ./plugins/lsp/friendly-snippets.nix
    ./plugins/lsp/lsp-config.nix
    ./plugins/lsp/nixd.nix
    ./plugins/lsp/tinymist.nix
    ./plugins/lsp/rustaceanvim.nix
  ];
  enableMan = false;
  clipboard.providers.wl-copy.enable = true;
  # I want to make it copy on keybind, but `+y` doesn't work for me, so this will do
  clipboard.register = "unnamedplus";
  # package = lib.mkIf (
  #   meta.system == "x86_64-linux"
  # ) inputs.neovim-nightly-overlay.packages.x86_64-linux.default;
  withRuby = false;
  # Performance
  luaLoader.enable = true;
  performance = {
    byteCompileLua = {
      enable = true;
      configs = true;
      luaLib = true;
      initLua = true;
      plugins = true;
      nvimRuntime = true;
    };
    combinePlugins.enable = true;
  };
}
