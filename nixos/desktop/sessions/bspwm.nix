{ config, lib, pkgs, ...}:

{
  options = {
    bspwm.enable = lib.mkEnableOption "enable bspwm";
  };

  config = lib.mkIf config.bspwm.enable {
    services.displayManager.defaultSession = "xfce+bspwm";
    xfce.enable = true;
    services.xserver = {
      enable = true;
      desktopManager.xfce = {
        enableXfwm = false;
      };
      windowManager.bspwm.enable = true;
    };
  };
}

