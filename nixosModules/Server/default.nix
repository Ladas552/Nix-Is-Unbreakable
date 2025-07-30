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
    ./homepage-dashboard
    ./immich
    ./jellyfin
    ./kavita
    ./miniflux
    ./ncps
    ./nextcloud
    ./radarr
    ./sonarr
  ];

}
