{
  pkgs,
  lib,
  meta,
  ...
}:

{
  customhm = {
    mako.enable = lib.mkDefault true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    plugins = with pkgs; [ ];
    settings = {
      monitor = lib.mkIf (meta.host == "NixToks") "eDP-1, 1920x1080@60, 0x0, 1";

      # Options
      general = {
        # Mouse control
        resize_on_border = true;
      };

      input = {
        # Keyboard layout
        kb_layout = "us,kz";
        kb_options = "grp:caps_toggle";
        numlock_by_default = true;
        # Mouse inputs
        accel_profile = "flat";
        touchpad = {
          disable_while_typing = false;
          natural_scroll = true;
          scroll_factor = 0.2;
        };
      };

      misc = {
        font_family = "JetBrainsMono NFM Regular";
        splash_font_family = "splash_font_family";
      };
      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      binds = {
        workspace_back_and_forth = true;
        allow_workspace_cycles = true;
      };

      xwayland.force_zero_scaling = true;

      # Nvidia ENV
      opengl.nvidia_anti_flicker = false;
      env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];

      # Keybinds
      bind = [
        "SUPER, T, exec, ghostty"
        "SUPER, W, exec, floorp"
        "SUPER, space, exec, rofi -show"
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
      ];

      # autostart
      exec-once = [
        "thunar -d"
        "xfce4-power-manager --daemon"
      ];

    };
  };
}
