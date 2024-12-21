{
  lib,
  pkgs,
  config,
  inputs,
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
      pam.enable = lib.mkDefault true;
    };

    environment.systemPackages = with pkgs; [ xwayland-satellite ];

    environment.variables = {
      # Display is for xwayland-satellite, and it doesn't work here. But if this variable is set in niri config it seems to work
      NIXOS_OZONE_WL = "1";
      DISPLAY = ":0";
    };

    programs.niri = {
      enable = true;
      package = pkgs.niri;
    };

    home-manager = {
      users."ladas552" = import ./home.nix;
    };
  };
}
