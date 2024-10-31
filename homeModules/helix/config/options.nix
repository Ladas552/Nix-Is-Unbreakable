{ ... }:

{
  programs.helix.settings = {
    theme = "adwaita-dark";
    editor = {
      # LSP
      lsp = {
        display-inlay-hints = true;
      };
      inline-diagnostics = {
        cursor-line = "warning";
      };
      # end-of-line-diagnostics = "hint";
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
        timeout = 2000;
      };
      file-picker = {
        hidden = false;
      };
    };
  };
}
