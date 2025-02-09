{ config, lib, ... }:

{
  options.custom = {
    otd.enable = lib.mkEnableOption "enable otd";
  };

  config = lib.mkIf config.custom.otd.enable {
    # Configure tablet
    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };
}
