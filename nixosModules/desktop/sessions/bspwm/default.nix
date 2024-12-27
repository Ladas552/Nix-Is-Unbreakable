{
  config,
  lib,
  user,
  ...
}:

{
  options.custom = {
    bspwm.enable = lib.mkEnableOption "enable bspwm";
  };

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

    home-manager = {
      users."${user}" = import ./bspwm.nix;
    };
  };
}
