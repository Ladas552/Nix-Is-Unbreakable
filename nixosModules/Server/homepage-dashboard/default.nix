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
    # caddy
    services.caddy.virtualHosts."${config.custom.homelab.baseDomain}" = {
      extraConfig = ''
        reverse_proxy localhost:8082
      '';
    };

    # modules
    services.homepage-dashboard = {
      enable = true;
      allowedHosts = "${config.custom.homelab.baseDomain}";
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
          "Share/Download files" = [
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
              "Qbittorrent" = {
                description = "Torrents";
                href = "http://${config.custom.homelab.ip}:8081";
              };
            }
            {
              "Karakeep" = {
                description = "Bookmark manager";
                href = "http://${config.custom.homelab.ip}:9221";
              };
            }
          ];
        }
        {
          "Media" = [
            {
              "Jellyfin" = {
                description = "Watch";
                href = "http://${config.custom.homelab.ip}:8096";
              };
            }

            {
              "Kavita" = {
                description = "Books";
                href = "http://${config.custom.homelab.ip}:5000";
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
        {
          "Doesn't work" = [
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
