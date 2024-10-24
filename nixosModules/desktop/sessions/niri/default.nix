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

    xdg.portal = {
      enable = lib.mkDefault true;
      xdgOpenUsePortal = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config = {
        common.default = "gtk";
        obs.default = "wlr";
      };
    };

    home-manager.users."ladas552" = {
      home.file.".config/niri/config.kdl" = {
        source = ./config.kdl;
      };
      home.shellAliases = {
        niv = "niri validate -c ~/Nix-dots/nixosModules/desktop/sessions/niri/config.kdl ";
      };
      customhm = {
        mako.enable = lib.mkDefault true;
        swaylock.enable = lib.mkDefault true;
        wpaperd.enable = lib.mkDefault true;
      };
    };
  };
}
