{
  config,
  lib,
  meta,
  ...
}:

{
  options.custom = {
    homepage-dashboard.enable = lib.mkEnableOption "enable homepage-dashboard";
  };

  config = lib.mkIf config.custom.homepage-dashboard.enable {
    # secret
    sops.secrets."mystuff/homepage".neededForUsers = true;
    sops.secrets."mystuff/homepage" = { };

    # modules
    services.homepage-dashboard = {
      enable = true;
      environmentFile = config.sops.secrets."mystuff/homepage".path;
      settings = { };
      widgets = [
        {
          resources = {
            cpu = true;
            cputemp = true;
            uptime = true;
            disk = "/";
            memory = true;
          };
        }
        {
          resources = {
            label = "HDD";
            disk = "/mnt/zmedia";
          };
        }
        {
          search = {
            provider = "duckduckgo";
            target = "_blank";
          };
        }
        {
          openmeteo = {
            latitude = 51.1801;
            longitude = 71.446;
            timezone = config.time.timeZone;
            units = "metric";
          };
        }
      ];
      services = [
        {
          "My services" = [
            {
              "Immich" = {
                description = "Photos";
                href = "http://${config.services.immich.host}:2283";
              };
            }
            {
              "NextCloud" = {
                description = "Drive";
                href = "http://${config.custom.homelab.ip}:8080";
              };
            }
            {
              "Kavita" = {
                description = "Books";
                href = "http://${config.custom.homelab.ip}:5000";
              };
            }
            {
              "Deluge" = {
                description = "Torrents";
                href = "http://${config.custom.homelab.ip}:8112";
              };
            }
            {
              "Sonarr" = {
                description = "TV Shows";
                href = "http://${config.custom.homelab.ip}:8989";
              };
            }
            {
              "Radarr" = {
                description = "Movies";
                href = "http://${config.custom.homelab.ip}:7878";
              };
            }
            {
              "Jellyfin" = {
                description = "Watch";
                href = "http://${config.custom.homelab.ip}:8096";
              };
            }
            {
              "Miniflux" = {
                description = "RSS feed";
                href = "http://${config.custom.homelab.ip}:8067";
              };
            }
          ];
        }

      ];
      bookmarks = [ ];

    };
    networking.firewall.interfaces.ztcfwrb2q6.allowedTCPPorts = lib.mkIf config.custom.zerotier.enable [
      8082
    ]; # Only allow ZeroTier
    networking.firewall.interfaces.tailscale0.allowedTCPPorts =
      lib.mkIf config.custom.tailscale.enable
        [ 8082 ]; # Only allow Tailscale
  };
}
