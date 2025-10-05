{
  config,
  lib,
  ...
}:

{
  options.custom = {
    kde.enable = lib.mkEnableOption "enable kde";
  };
  config = lib.mkIf config.custom.kde.enable {
    custom.greetd.enable = false;
    # https://github.com/Red-Flake/red-flake-nix/blob/main/nixos/modules/kde.nix
    services.displayManager = {
      # Enable SDDM
      sddm.enable = true;
      # Set default session to KDE Plasma
      defaultSession = "plasma";
      # Run SDDM under Wayland
      sddm.wayland.enable = true;
      # Set SDDM theme to breeze
      sddm.theme = "breeze";
    };

    # Desktop-Manager settings
    services.desktopManager = {
      # Enable Plasma 6
      plasma6.enable = true;
    };

    # Enable XWayland
    programs.xwayland.enable = true;
  };
}
