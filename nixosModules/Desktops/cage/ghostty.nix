{
  lib,
  pkgs,
  config,
  inputs,
  meta,
  ...
}:

{
  # cage environment using ghostty
  # special defined scripts and keybinds will be in there
  # scaling doesn't work btw
  options.custom = {
    cage.ghostty.enable = lib.mkEnableOption "enable cage-ghostty";
  };

  config = lib.mkIf config.custom.cage.ghostty.enable {

    environment.systemPackages = with pkgs; [
      brightnessctl
    ];

    services.cage = {
      enable = true;
      program = ''${lib.meta.getExe' pkgs.ghostty "ghostty"}'';
      extraArguments = [
        "-m"
        "extend"
      ];
      user = "${meta.user}";
      environment = {
        XKB_DEFAULT_LAYOUT = "us,kz";
         XKB_DEFAULT_OPTIONS = "grp:caps_toggle";
      };
    };

    home-manager.users."${meta.user}".customhm = {
      ghostty.enable = lib.mkDefault true;
    };
  };
}
