{ ... }:

{
  programs.helix.settings = {
    editor = {
      # LSP
      lsp = {
        display-inlay-hints = true;
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
      # Workflow
      auto-save.after-delay = {
        enable = true;
        timeout = 2000;
      };
    };
  };
}
