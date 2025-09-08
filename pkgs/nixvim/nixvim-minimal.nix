{
  imports = [
    # Neovim vanilla options
    ./config/autocmd.nix
    ./config/options.nix
    ./config/keymaps.nix
    ./config/colorscheme.nix
    ./config/diagnostics.nix

    # Plugins
    ./plugins/cmp/luasnip.nix
    ./plugins/cmp/blink-cmp.nix
    ./plugins/workflow/auto-save.nix
    ./plugins/workflow/img-clip.nix
    ./plugins/workflow/neogit.nix
    ./plugins/workflow/neorg.nix
    ./plugins/workflow/nvim-autopairs.nix
    ./plugins/workflow/oil.nix
    ./plugins/workflow/snacks.nix
    ./plugins/workflow/treesitter.nix
    ./plugins/ui/colorizer.nix
    ./plugins/ui/dashboard.nix
    ./plugins/ui/heirline.nix
    ./plugins/ui/numb.nix
    ./plugins/ui/web-devicons.nix
    ./plugins/ui/which-key.nix
    ./plugins/lsp/friendly-snippets.nix
  ];
  enableMan = false;
  withRuby = false;
  withPython3 = false;
  # Performance
  luaLoader.enable = true;
  performance = {
    byteCompileLua = {
      enable = true;
      nvimRuntime = true;
      plugins = true;
    };
    combinePlugins.enable = true;
  };
}
