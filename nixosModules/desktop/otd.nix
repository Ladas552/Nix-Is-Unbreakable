{ config, lib, pkgs, ... }:

{
  options.custom = { otd.enable = lib.mkEnableOption "enable otd"; };

  config = lib.mkIf config.custom.otd.enable {
    # Configure mouse/tablet in x11 
    hardware.opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };
}
