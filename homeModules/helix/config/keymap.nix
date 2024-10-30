{ ... }:

{
  programs.helix = {
    settings = {
      keys = {
        normal = {
          # Swap file pickers
          space.f = "file_picker_in_current_directory";
          space.F = "file_picker";
          # Usable goto last line
          G = "goto_last_line";
        };
      };
    };
  };
}
