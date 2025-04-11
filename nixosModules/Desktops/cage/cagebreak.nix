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

    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "${meta.user}";
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${lib.meta.getExe' pkgs.cagebreak "cagebreak"}";
          user = "${meta.user}";
        };
        default_session = initial_session;
      };
    };

    environment.variables = {
      WAYLAND_DEBUG = 1;
    };
    environment.systemPackages = with pkgs; [
      brightnessctl
      cagebreak
      kitty
    ];


    home-manager.users."${meta.user}".customhm = {
      kitty.enable = lib.mkDefault true;
    };
  };
}
