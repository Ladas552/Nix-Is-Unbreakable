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
    # How to write a custom sessions for display manager
    services.displayManager.sessionPackages = [
      (
        (pkgs.writeTextDir "share/wayland-sessions/niri.desktop" ''
          [Desktop Entry]
          Name=Niri
          Comment=うそぴょーん>x3
          Exec=${pkgs.niri}/bin/niri
          Type=Application
        '').overrideAttrs
        (_: {
          passthru.providedSessions = [ "niri" ];
        })
      )
    ];

    environment.systemPackages = with pkgs; [ niri ];

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    home-manager.users."ladas552".home.file.".config/niri/config.kdl" = {
      source = ./config.kdl;
    };
  };
}
