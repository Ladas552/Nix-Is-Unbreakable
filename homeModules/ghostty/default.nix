{
  lib,
  config,
  inputs,
  meta,
  ...
}:

{

  options.customhm = {
    ghostty.enable = lib.mkEnableOption "enable ghostty";
  };
  config = lib.mkIf config.customhm.ghostty.enable {
    programs.ghostty = {
      enable = true;
      # Use ghostty master branch from Flake
      ## It started to build instead of downloading quite often
      # package = inputs.ghostty.packages.x86_64-linux.default;
      enableFishIntegration = true;
      enableBashIntegration = true;
      # Colors
      themes = {
        # Dracula + Catppuccin
        dracata = {
          background = "#181B28";
          foreground = "#F8F8F2";
          # black
          palette = [
            "0=#000000"
            "8=#545454"
            # red
            "1=#FF5555"
            "9=#FF5454"
            # green
            "2=#50FA7B"
            "10=#50Fa7B"
            # yellow
            "3=#DA00E9"
            "11=#F0FA8B"
            # blue
            "4=#BD92F8"
            "12=#BD92F8"
            # purple
            "5=#FF78C5"
            "13=#FF78C5"
            # aqua
            "6=#8AE9FC"
            "14=#8AE9FC"
            # white
            "7=#BBBBBB"
            "15=#FFFFFF"
          ];
        };
      };
      settings = {
        # To look at docs for settings use:
        # ghostty +show-config --docs --default | nvim
        # Windows
        background-opacity = 0.95;
        background-blur-radius = 20;
        window-padding-x = 2;
        window-padding-y = 2;
        window-padding-color = "extend";
        window-vsync = false;
        window-inherit-font-size = false;
        window-theme = "dark";
        resize-overlay = "never";
        gtk-titlebar = if meta.host == "NixwsL" then true else false;
        window-decoration = if meta.host == "NixwsL" then true else false;
        confirm-close-surface = false;
        gtk-tabs-location = "bottom";
        gtk-single-instance = true;
        # Shaders
        # custom-shader = "${inputs.ghostty-shaders}/glitchy.glsl";

        # Shell
        command = "fish";
        shell-integration = "fish";
        working-directory = "inherit";
        cursor-click-to-move = true;
        # Font
        # bold-is-bright = true;
        #freetype-load-flags = "no-hinting,no-force-autohint,no-monochrome,no-autohint";
        #font-family = "Pixel Code";

        # Keybinds

        keybind = [
          "ctrl+shift+minus=decrease_font_size:1"
          "ctrl+shift+plus=increase_font_size:1"
          "ctrl+shift+backspace=reset_font_size"
          "ctrl+shift+f5=reload_config"
          # "ctrl+shift+down=scroll_page_down"
          # "ctrl+shift+up=scroll_page_up"
          "ctrl+shift+up=scroll_page_lines:-10"
          "ctrl+shift+down=scroll_page_lines:10"
        ];
      };
    };
  };
}
