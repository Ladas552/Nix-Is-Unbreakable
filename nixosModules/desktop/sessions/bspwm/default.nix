{
  config,
  lib,
  ...
}:

{
  options.custom = {
    bspwm.enable = lib.mkEnableOption "enable bspwm";
  };

  imports = [ ./bspwm.nix ];

  config = lib.mkIf config.custom.bspwm.enable {
    services.displayManager.defaultSession = "xfce+bspwm";
    custom.xfce.enable = true; # enable a different custom module
    services.xserver = {
      enable = true;
      windowManager.bspwm.enable = true;
      desktopManager.xfce = {
        enableXfwm = false;
      };
    };
  };
}
