{
  config,
  lib,
  pkgs,
  inputs,
  meta,
  ...
}:

{
  options.custom = {
    general.enable = lib.mkEnableOption "enable general";
  };

  config = lib.mkIf config.custom.general.enable {
    # Disable nano
    programs.nano.enable = false;
    # Enable Swaylock to unlock the screen
    security.pam.services.swaylock = { };
    # Disable X11 prompt for Git. Changes work only after Reboot for some reason
    # Here is the issue: https://github.com/NixOS/nixpkgs/issues/24311
    programs.ssh.askPassword = "";
    # Define your hostname.
    networking.hostName = "${meta.host}";

    # Set your time zone.
    time.timeZone = "Asia/Almaty";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };

  };
}
