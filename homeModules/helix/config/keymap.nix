{ ... }:

{
  programs.helix = {
    settings = {
      keys = {
        normal = {
          # Swap file pickers
          space = {
            f = "file_picker_in_current_directory";
            F = "file_picker";
            e = "file_picker_in_current_directory";
            E = "file_picker";
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
          space.K = "signature_help";
        };
      };
    };
  };
}
