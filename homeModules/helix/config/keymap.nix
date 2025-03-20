{ lib, meta, ... }:

{
  programs.helix = {
    settings = {
      keys = {
        normal = {
          # Swap file pickers
          space = {
            e =
              if meta.isTermux then
                "file_picker_in_current_directory"
              else
                "file_explorer_in_current_buffer_directory";
            E = if meta.isTermux then "file_picker" else "file_explorer";
            f = "file_picker_in_current_directory";
            F = "file_picker";
          };
          # Muscle  Memory
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];
          i = [
            "insert_mode"
            "collapse_selection"
          ];
          a = [
            "append_mode"
            "collapse_selection"
          ];
          G = "goto_last_line";
          # Buffer managment
          space = {
            "," = ":buffer-previous";
            "." = ":buffer-next";
            "x" = ":buffer-close";
          };
          "=" = ":format";
          K = "signature_help";
        };
      };
    };
  };
}
