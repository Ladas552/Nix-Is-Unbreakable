{ lib, config, ... }:
{
  options.custom = {
    homelab.ip = lib.options.mkOption {
      description = "ip of my current homelab";
      default = "10.144.32.1";
      type = lib.types.str;
    };
  };
  imports = [
    ./deluge
    ./immich
    ./nextcloud
    ./kavita
    ./sonarr
    ./radarr
    ./homepage-dashboard
    ./ncps
  ];

}
