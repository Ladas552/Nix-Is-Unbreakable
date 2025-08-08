{ lib, config, ... }:
{
  options.custom = {
    homelab.ip = lib.options.mkOption {
      description = "ip of my current homelab";
      default = "127.0.0.1"; # local host
      type = lib.types.str;
    };
  };
  imports = [
    ./homepage-dashboard
    ./immich
    ./jellyfin
    ./kavita
    ./miniflux
    ./ncps
    ./nextcloud
    ./qbittorrent
    ./radarr
    ./sonarr
  ];
  config = {
    users.groups."media" = { };
  };
}
