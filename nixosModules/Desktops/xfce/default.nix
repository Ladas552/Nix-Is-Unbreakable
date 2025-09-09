{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom = {
    xfce.enable = lib.mkEnableOption "enable xfce";
    xfce.wayfire.enable = lib.mkEnableOption "enable xfce wayfire session";
    xfce.labwc.enable = lib.mkEnableOption "enable xfce labwc session";
    xfce.niri.enable = lib.mkEnableOption "enable xfce niri session";
  };
  # lib.mkMerge instead of lib.optionalAttrb because the later causes infinite recursion
  # only `xfce.enable` works as expected, because IDK how to launch the sessions with wayfire and labwc yet, the options in lightdm don't launch xfce in wayland mode
  config = lib.mkMerge [
    (lib.mkIf config.custom.xfce.enable {
      custom = {
        thunar.enable = true;
        libinput.enable = true;
        lightdm.enable = true;
      };
      services.xserver = {
        enable = true;
        desktopManager.xfce = {
          enable = true;
          enableXfwm = lib.mkDefault true;
        };
      };
      environment = {
        xfce.excludePackages = with pkgs.xfce; [
          mousepad
          parole
          ristretto
          xfce4-appfinder
          xfce4-screenshooter
          xfce4-taskmanager
          xfce4-terminal
        ];
        systemPackages = with pkgs.xfce; [
          xfce4-xkb-plugin
          xfce4-timer-plugin
          xfce4-weather-plugin
        ];
      };
    })
    # These sessions don't work as expected, but I can make them work in the future
    (lib.mkIf config.custom.xfce.wayfire.enable {
      custom.wayfire.enable = true;
      services.xserver.desktopManager.xfce.waylandSessionCompositor = "wayfire";
    })
    (lib.mkIf config.custom.xfce.labwc.enable {
      custom.labwc.enable = true;
      services.xserver.desktopManager.xfce.waylandSessionCompositor = "labwc --startup";
    })
    (lib.mkIf config.custom.xfce.niri.enable {
      custom.niri.enable = true;
      services.xserver.desktopManager.xfce.waylandSessionCompositor = "niri";
    })
  ];
}
