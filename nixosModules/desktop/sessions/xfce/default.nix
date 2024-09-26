{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom = {
    xfce.enable = lib.mkEnableOption "enable xfce";
  };

  config = lib.mkIf config.custom.xfce.enable {
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
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-volman
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };

  };
}
