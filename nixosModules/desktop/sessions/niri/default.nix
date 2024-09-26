{
  lib,
  pkgs,
  config,
  ...
}:

{

  options.custom = {
    niri.enable = lib.mkEnableOption "enable niri";
  };

  config = lib.mkIf config.custom.niri.enable {
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    home-manager.users."ladas552".home.file.".config/niri/config.kdl" = {
      source = ./config.kdl;
    };
  };
}
