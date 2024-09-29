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
    custom = {
      thunar.enable = true;
    };

    home-manager.users."ladas552" = {
      home.shellAliases = {
        niv = "niri validate -c ~/Nix-dots/nixosModules/desktop/sessions/niri/config.kdl ";
      };
      customhm = {
        mako.enable = lib.mkDefault true;
      };
    };

    # How to write a custom sessions for display manager
    services.displayManager.sessionPackages = [
      (
        (pkgs.writeTextDir "share/wayland-sessions/niri.desktop" ''
          [Desktop Entry]
          Name=Niri
          Comment=why not
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
      config.common.default = "*";
    };

    environment.variables = {
      __NV_PRIME_RENDER_OFFLOAD = 1;
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    home-manager.users."ladas552".home.file.".config/niri/config.kdl" = {
      source = ./config.kdl;
    };
  };
}
