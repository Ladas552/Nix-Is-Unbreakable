{ config, lib, pkgs, ...}:

{
  options.custom = {
    bspwm.enable = lib.mkEnableOption "enable bspwm";
  };

  config = lib.mkIf config.custom.bspwm.enable {
    services.displayManager.defaultSession = "xfce+bspwm";
    custom.xfce.enable = true; # enable a different custom module
    services.xserver = {
      enable = true;
      desktopManager.xfce = {
        enableXfwm = false;
      };
      windowManager.bspwm.enable = true;
    };
  };
}

