{
  config,
  lib,
  ...
}:

{
  options.custom = {
    bspwm.enable = lib.mkEnableOption "enable bspwm";
  };

  config = lib.mkIf config.custom.bspwm.enable {
    services.displayManager.defaultSession = "xfce+bspwm";
    custom.xfce.enable = true; # enable a different custom module
    home-manager.users."ladas552".customhm.bspwm.enable = true;
    services.xserver = {
      enable = true;
      windowManager.bspwm.enable = true;
      desktopManager.xfce = {
        enableXfwm = false;
      };
    };
  };
}
