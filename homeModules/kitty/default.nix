{
  lib,
  config,
  ...
}:

{

  options.customhm = {
    kitty.enable = lib.mkEnableOption "enable kitty";
  };
  config = lib.mkIf config.customhm.kitty.enable {
    programs.kitty = {
      enable = true;
      font = lib.mkForce {
        name = "JetBrainsMonoNL Nerd Font Mono";
        size = 16.0;
      };
      settings = {
        #kitty.conf
        enable_audio_bell = false;
        shell = "fish";
        url_style = "single";
        cursor_shape = "block";
        scrollback_lines = 2000;
        confirm_os_window_close = 0;
        font_size = 11;
        background = "#181B28";
        foreground = "#F8F8F2";
        selection_foreground = "#1E1F28";
        selection_background = "#44475A";
        color0 = "#000000"; # Black
        color1 = "#FF5555"; # RED
        color2 = "#50FA7B"; # GREEN
        color3 = "#DA00E9"; # HIGHLIGH
        color4 = "#BD92F8"; # BLUE
        color5 = "#FF78C5"; # MAGENTA
        color6 = "#8AE9FC"; # CYAN
        color7 = "#BBBBBB"; # WHITE
        color8 = "#545454"; # BR BLACK
        color9 = "#FF5454"; # BR RED
        color10 = "#50FA7B"; # BR GREEN
        color11 = "#F0FA8B"; # BR YELLOW
        color12 = "#BD92F8"; # BR BLUE
        color13 = "#FF78C5"; # BR MAGENTA
        color14 = "#8AE9FC"; # BR CYAN
        color15 = "#FFFFFF"; # BR WHITE
        url_color = "#0087BD"; # URL
        cursor = "#F4DBD6";
        cursor_text_color = "#24273A";
        active_border_color = "#B7BDF8";
        inactive_border_color = "#6E738D";
        bell_border_color = "#EED49F";
        active_tab_foreground = "#181926";
        active_tab_background = "#C6A0F6";
        inactive_tab_foreground = "#CAD3F5";
        inactive_tab_background = "#1E2030";
        tab_bar_background = "#181926";
      };
    };
# Breaks ssh
 #   home.sessionVariables = {
  #  TERMINAL = "kitty";
   #   TERM = "kitty";
  #  };
  };
}
