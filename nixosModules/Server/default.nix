{ lib, config, ... }:
{
  options.custom.homelab = {
    baseDomain = lib.mkOption {
      default = "nixtoks.taila7a93b.ts.net";
      type = lib.types.str;
      description = ''
        Base domain name to be used to access the homelab services via Caddy reverse proxy
      '';
    };
    ip = lib.options.mkOption {
      description = "ip of my current homelab";
      type = lib.types.str;
      default = "100.74.112.27"; # Tailnet ip
    };
  };
  imports = [
    ./homepage-dashboard
    ./immich
    ./jellyfin
    ./karakeep
    ./kavita
    ./miniflux
    ./ncps
    ./nextcloud
    ./qbittorrent
    ./radarr
    ./sonarr
  ];
}
