{ config, lib, pkgs, ...}:

{
  options = {
    bluetooth.enable = lib.mkEnableOption "enable bluetooth";
  };

  config = lib.mkIf config.bluetooth.enable {

    # Bluetooth
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = false; # powers up the default Bluetooth controller on boot
    services.blueman.enable = true;
  };
}
