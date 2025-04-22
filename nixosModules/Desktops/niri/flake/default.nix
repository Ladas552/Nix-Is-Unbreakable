{
  lib,
  pkgs,
  config,
  inputs,
  meta,
  ...
}:

{
  # Niri using flake, testing
  options.custom = {
    niri.enable = lib.mkEnableOption "enable niri";
  };
  imports = [
    inputs.niri.nixosModules.niri
    ./greetd.nix
  ];

  config = lib.mkIf config.custom.niri.enable {
    custom = {
      thunar.enable = lib.mkDefault true;
    };

    environment.systemPackages = with pkgs; [
      xwayland-satellite
      brightnessctl
      xfce.xfce4-power-manager
    ];

    environment.variables = {
      # Display is for xwayland-satellite, and it doesn't work here. But if this variable is set in niri config it seems to work
      NIXOS_OZONE_WL = "1";
      DISPLAY = ":0";
    };

    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    xdg.portal = {
      enable = lib.mkDefault true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
      ];
      config = {
        niri."org.freedesktop.impl.portal.FileChooser" = "gtk";
      };
    };

    home-manager = {
      users."${meta.user}" = import ./home.nix;
    };
  };
}
