{
  config,
  lib,
  meta,
  ...
}:

{
  options.custom = {
    general.enable = lib.mkEnableOption "enable general";
  };

  config = lib.mkIf config.custom.general.enable {
    # Updates firmware directly from vendors
    services.fwupd.enable = true;
    # clear out journalctl logs
    services.journald.extraConfig = "MaxRetentionSec=14day";
    # Allow core dumps
    systemd.coredump.enable = true;
    # Disable nano
    programs.nano.enable = false;
    # Enable Swaylock to unlock the screen
    security.pam.services.swaylock = { };
    # Disable X11 prompt for Git. Changes work only after Reboot for some reason
    # Here is the issue: https://github.com/NixOS/nixpkgs/issues/24311
    programs.ssh.askPassword = "";
    # Define your hostname.
    networking.hostName = "${meta.host}";
    # something stolen from https://kokada.dev/blog/an-unordered-list-of-hidden-gems-inside-nixos/
    ## Faster wifi connection
    networking.networkmanager.wifi.backend = "iwd";
    ## Using cpu to comress RAM like swap
    zramSwap = {
      enable = true;
      algorithm = "zstd";
    };
    ## Suppousetly faster dbus
    services.dbus.implementation = "broker";

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
    custom.imp = {
      home = {
        cache = {
          files = [ ".local/share/nix/repl-history" ];
        };
      };
    };
  };
}
