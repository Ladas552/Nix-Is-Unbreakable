{
  config,
  lib,
  meta,
  ...
}:

{
  options.custom = {
    bluetooth.enable = lib.mkEnableOption "enable bluetooth";
  };

  config = lib.mkIf config.custom.bluetooth.enable {

    # Bluetooth
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = if meta.host == "NixPort" then true else false; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true;

    # home-manager.users."${meta.user}".services.mpris-proxy.enable = true;

    hardware.bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
}
