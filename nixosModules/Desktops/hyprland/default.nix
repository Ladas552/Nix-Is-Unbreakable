{
  lib,
  pkgs,
  config,
  inputs,
  meta,
  ...
}:

{
  # Hyprland
  options.custom = {
    hyprland.enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf config.custom.hyprland.enable {

    custom = {
      thunar.enable = true;
      greetd.command = "uwsm start ${pkgs.hyprland}/share/wayland-sessions/hyprland.desktop";
    };

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    environment.systemPackages = with pkgs; [
      brightnessctl
      xfce.xfce4-power-manager
      custom.rofi-powermenu
      custom.wpick
    ];

    environment.variables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_LAUNCH_FLAGS = "--enable-wayland-ime --wayland-text-input-version=3 --enable-features=WaylandLinuxDrmSyncobj";
    };

    home-manager.users."${meta.user}" = import ./home.nix;

    # persist for Impermanence
    custom.imp.home.cache.directories = [ ".cache/hyprland" ];
  };
}
