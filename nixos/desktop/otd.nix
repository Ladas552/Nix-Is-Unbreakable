{ config, lib, pkgs, ...}:


{
  options = {
    otd.enable = lib.mkEnableOption "enable otd";
  };

  config = lib.mkIf config.otd.enable {
    # Configure mouse/tablet in x11 
    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };
}
