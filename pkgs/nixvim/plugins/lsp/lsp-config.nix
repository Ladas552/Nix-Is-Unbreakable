{ pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins."lspkind-nvim" ];
  plugins.lsp = {
    enable = true;
    inlayHints = true;
    keymaps = {
      silent = true;
      diagnostic = {
        # Navigate in diagnostics
        "<leader>[" = "goto_prev";
        "<leader>]" = "goto_next";
      };
      lspBuf = {
        "<leader>ld" = "definition";
        "<C-LeftMouse>" = "definition";
        "<F2>" = "rename";
        "<leader>lD" = "implementation";
        "<leader>lc" = "code_action";
        K = "hover";
      };
    };
  };

}
