{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom = {
    tlp.enable = lib.mkEnableOption "enable tlp";
  };

  config = lib.mkIf config.custom.tlp.enable {
    powerManagement.enable = true;
    services.tlp.enable = true;
    services.power-profiles-daemon.enable = false;
  };
}
