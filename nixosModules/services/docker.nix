{ config, lib, ... }:
{
  options.custom = {
    docker.enable = lib.mkEnableOption "enable docker";
  };

  config = lib.mkIf config.custom.docker.enable {
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
      daemon.settings = {
        data-root = "/home/ladas552/Projects/Dockers";
      };
    };
  };
}
