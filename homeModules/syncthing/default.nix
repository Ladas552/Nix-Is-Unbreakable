{ lib, config, ... }:

{

  options.customhm = {
    syncthing.enable = lib.mkEnableOption "enable syncthing";
  };
  config = lib.mkIf config.customhm.syncthing.enable {
    services.syncthing = {
      enable = true;
    };

    # persist for Impermanence
    customhm.imp.home.cache.directories = [ ".local/state/syncthing" ];
  };
}
