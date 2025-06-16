{
  pkgs,
  lib,
  meta,
  ...
}:

{
  customhm = {
    mako.enable = lib.mkDefault true;
    swaylock.enable = lib.mkDefault true;
    wpaperd.enable = lib.mkDefault true;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    plugins = with pkgs; [ ];
    settings = {

      # Options
      general = {
        # Mouse control
        resize_on_border = true;
      };

      inputs = {
        # Keyboard layout
        kb_layout = "us,kz";
        kb_options = "grp:caps_toggle";
        numlock_by_default = true;
        # Mouse inputs
        accel_profile = "flat";
        touchpad = {
          disable_while_typing = false;
          natural_scroll = true;
        };
      };

      misc = {
        font_family = "JetBrainsMono NFM Regular";
        splash_font_family = "splash_font_family";
      };
      Ecosystem = {
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
      ];

      # autostart
      exec-once = [
        "thunar -d"
        "xfce4-power-manager --daemon"
      ];

    };
  };
}
