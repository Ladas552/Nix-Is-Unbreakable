{
  lib,
  pkgs,
  config,
  inputs,
  meta,
  ...
}:

{
  # cagebreak
  # ghostty doesn't work with it btw
  # https://github.com/ghostty-org/ghostty/discussions/7045
  options.custom = {
    cage.cagebreak.enable = lib.mkEnableOption "enable cagebreak";
  };

  config = lib.mkIf config.custom.cage.cagebreak.enable {

    # init cagebreak ghostty session
    custom.greetd.command = "${lib.meta.getExe' pkgs.cagebreak "cagebreak"}";

    environment.variables = {
      WAYLAND_DEBUG = 1;
    };
    environment.systemPackages = with pkgs; [
      brightnessctl
      cagebreak
    ];


    home-manager.users."${meta.user}".customhm = {
      kitty.enable = lib.mkDefault true;
    };
  };
}
