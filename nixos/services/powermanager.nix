{ config, lib, pkgs, ...}:
{
  options.custom = {
    powermanager.enable = lib.mkEnableOption "enable powermanager";
  };

  config = lib.mkIf config.custom.powermanager.enable {
    powerManagement.enable = true;
    services.tlp.enable = true;
    services.power-profiles-daemon.enable = false;
  };
}
