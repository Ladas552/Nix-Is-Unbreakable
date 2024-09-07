{ config, lib, pkgs, ...}:

{
  options.custom = {
    syncthing.enable = lib.mkEnableOption "enable syncthing";
  };

  config = lib.mkIf config.custom.syncthing.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
    };
  };
}
