{
  lib,
  pkgs,
  config,
  meta,
  ...
}:

{
  # Niri module that doesn't use niri-flake
  options.custom = {
    niri.enable = lib.mkEnableOption "enable niri";
  };

  config = lib.mkIf config.custom.niri.enable {
    # kdl config
    home-manager.users."${meta.user}" = import ./home.nix;

    custom = {
      thunar.enable = lib.mkDefault true;
      # init niri session
      greetd.command = "${lib.meta.getExe' pkgs.niri "niri-session"}";
    };

    programs.niri.enable = true;

    environment.systemPackages = with pkgs; [
      xwayland-satellite
      brightnessctl
      xfce.xfce4-power-manager
      custom.rofi-powermenu
      custom.wpick
    ];

    environment.variables = {
      # Display is for xwayland-satellite, and it doesn't work here. But if this variable is set in niri config it seems to work
      NIXOS_OZONE_WL = "1";
      DISPLAY = ":0";
    };
    environment.pathsToLink = [
      "/share/xdg-desktop-portal"
      "/share/applications"
    ];
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
      config = {
        niri."org.freedesktop.impl.portal.FileChooser" = "gtk";
        niri.default = "gnome";
        common.default = "gnome";
        obs.default = "gnome";
      };
    };

  };
}
