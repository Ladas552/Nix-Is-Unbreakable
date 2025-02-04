{ meta, ... }:

{
  programs.helix.settings = {
    theme = if meta.isTermux then "adwaita-dark" else "catppuccin_macchiato";
    editor = {
      # LSP
      lsp = {
        display-inlay-hints = true;
        # to remove useless text
        auto-signature-help = false;
        display-signature-help-docs = false;
      };
      inline-diagnostics = {
        cursor-line = "warning";
      };
      # UI
      line-number = "relative";
      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "block";
      };
      gutters.layout = [
        "line-numbers"
        "spacer"
        "diagnostics"
      ];
      indent-guides = {
        render = true;
        character = "·";
        skip-levels = 2;
      };
      soft-wrap = {
        enable = true;
        wrap-indicator = "";
      };
      true-color = true;
      undercurl = true;
      bufferline = "multiple";
      popup-border = "menu";
      # Workflow
      auto-save.after-delay = {
        enable = true;
        timeout = 1000;
      };
      file-picker = {
        hidden = false;
      };
    };
  };
}
