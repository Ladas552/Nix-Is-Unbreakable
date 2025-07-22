{ lib, meta, ... }:

{
  programs.helix = {
    settings = {
      keys = {
        select = {
          "C-c" = "toggle_block_comments";
          G = "goto_last_line";
          # better manual surrouns
          m.s = "select_textobject_around";
          m.a = "surround_add";
          "$" = "goto_line_end";
        };
        insert = {
          "C-backspace" = "delete_word_backward";
          "C-w" = "delete_word_backward";
        };
        normal = {
          # comment blocks instead of line comments
          "A-c" = "toggle_block_comments";
          # Swap file pickers
          space = {
            e = "file_explorer_in_current_buffer_directory";
            E = "file_explorer";
            f = "file_picker_in_current_directory";
            F = "file_picker";
          };
          # better manual surrouns
          m.s = "select_textobject_around";
          m.a = "surround_add";
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
          "$" = "goto_line_end";
        };
      };
    };
  };
}
