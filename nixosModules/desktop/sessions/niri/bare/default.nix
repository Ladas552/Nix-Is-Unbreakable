{
  lib,
  pkgs,
  config,
  user,
  self,
  ...
}:

{
  # It is self made for my own machine config and I am switching to Niri flake so it stays as back up yes shut up idc
  options.custom = {
    niri.enable = lib.mkEnableOption "enable niri";
  };
  imports = [ ./greetd.nix ];

  config = lib.mkIf config.custom.niri.enable {
    custom = {
      thunar.enable = lib.mkDefault true;
      pam.enable = lib.mkDefault true;
    };

    environment.systemPackages = with pkgs; [
      niri
      xwayland-satellite
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
      enable = lib.mkDefault true;
      xdgOpenUsePortal = true;
      # wlr.enable = true;
      # extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      config = {
        common.default = "gnome";
        obs.default = "gnome";
      };
    };
    home-manager.users."${user}" = {
      home.file.".config/niri/config.kdl" = {
        source = ./config.kdl;
      };
      home.shellAliases = {
        niv = "niri validate -c ${self}/nixosModules/desktop/sessions/niri/bare/config.kdl ";
      };
      xdg.portal.enable = true;
      xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      xdg.portal.config = {
        common.default = "gnome";
        obs.default = "gnome";
      };
      customhm = {
        mako.enable = lib.mkDefault true;
        swaylock.enable = lib.mkDefault true;
        wpaperd.enable = lib.mkDefault true;
      };
    };
  };
}
