{ lib, config, ... }:

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
        color0 = "#000000"; # black
        color1 = "#ff5555"; # red
        color2 = "#50fa7b"; # green
        color3 = "#da00e9"; # highligh
        color4 = "#bd92f8"; # blue
        color5 = "#ff78c5"; # magenta
        color6 = "#8ae9fc"; # cyan
        color7 = "#bbbbbb"; # white
        color8 = "#545454"; # br black
        color9 = "#ff5454"; # br red
        color10 = "#50fa7b"; # br green
        color11 = "#f0fa8b"; # br yellow
        color12 = "#bd92f8"; # br blue
        color13 = "#ff78c5"; # br magenta
        color14 = "#8ae9fc"; # br cyan
        color15 = "#ffffff"; # br white
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
