{pkgs, lib, config, inputs, ...}:

{

  options.customhm = {
    syncthing.enable = lib.mkEnableOption "enable syncthing";
  };
  config = lib.mkIf config.customhm.syncthing.enable {
    services.syncthing = {
      enable = true;
    };
  };
}
