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

    services.caddy = {
      enable = true;
    };

    # Open firewall ports
    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
  };
}
