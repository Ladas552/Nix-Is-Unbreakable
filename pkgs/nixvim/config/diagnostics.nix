{ ... }:
{
  # Config for diagnostics with lsp
  diagnostic.settings =
    let
      sy = "vim.diagnostic.severity";
      rsy = "__rawKey__vim.diagnostic.severity";
    in
    {
      underline = {
        enable = true;
        severity.min.__raw = ''${sy}.WARN'';
      };
      virtual_lines = {
        enable = true;
        current_line = true;
      };
      virtual_text = false;
      update_in_insert = true;
      severity_sort = true;
      float = {
        source = "if_many";
        border = "rounded";
        show_header = false;
      };
      signs = {
        severity.min.__raw = ''${sy}.HINT'';
        text = {
          "${rsy}.ERROR" = "";
          "${rsy}.WARN" = "";
          "${rsy}.INFO" = "";
          "${rsy}.HINT" = "";
        };
        numhl = {
          "${rsy}.ERROR" = "DiagnosticSignError";
          "${rsy}.WARN" = "DiagnosticSignWarn";
          "${rsy}.INFO" = "DiagnosticSignInfo";
          "${rsy}.HINT" = "DiagnosticSignHint";
        };
      };
    };

}
