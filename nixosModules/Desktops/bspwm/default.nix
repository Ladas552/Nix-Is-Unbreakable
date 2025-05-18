{
  config,
  lib,
  pkgs,
  meta,
  ...
}:

{
  options.custom = {
    bspwm.enable = lib.mkEnableOption "enable bspwm";
  };

  config = lib.mkIf config.custom.bspwm.enable {
    services.displayManager.defaultSession = "xfce+bspwm";
    custom = {
      xfce.enable = true; # enable a different custom module
      greetd.command = "${lib.meta.getExe' pkgs.xfce.xfce4-session "startxfce4"}";
    };
    services.xserver = {
      enable = true;
      windowManager.bspwm.enable = true;
      desktopManager.xfce = {
        enableXfwm = false;
      };
    };

    home-manager = {
      users."${meta.user}" = import ./bspwm.nix;
    };
  };
}
