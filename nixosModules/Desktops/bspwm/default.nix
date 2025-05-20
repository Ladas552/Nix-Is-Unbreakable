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
      lightdm.enable = true;
    };
    services.xserver = {
      enable = true;
      windowManager.bspwm.enable = true;
      desktopManager.xfce = {
        enableXfwm = false;
      };
    };

    environment.variables = {
      # https://wiki.archlinux.org/title/Bspwm#Performance_issues_using_fish
      SXHKD_SHELL = "${lib.getExe' pkgs.dash "dash"}";
    };
    home-manager = {
      users."${meta.user}" = import ./bspwm.nix;
    };
  };
}
