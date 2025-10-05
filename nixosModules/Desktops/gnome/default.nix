{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom = {
    gnome.enable = lib.mkEnableOption "enable gnome";
  };
  config = lib.mkIf config.custom.gnome.enable {
    custom.greetd.enable = false;

    # enable DE and most of gnome services
    services.desktopManager.gnome.enable = true;

    services.gnome = {
      gnome-browser-connector.enable = true;
      # idk why games are enabled by default
      games.enable = false;
    };

    # Display manager
    services.displayManager.gdm.enable = true;

    # Enable XWayland
    programs.xwayland.enable = true;

    # plugins
    environment.systemPackages = [
      pkgs.gnomeExtensions.paperwm
    ];

    # persist for Impermanence
    custom.imp = {
      home.cache.files = [ ".config/gnome-initial-setup-done" ];
    };
  };
}
