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
          ];
        }
      ];
      bookmarks = [ ];

    };
    networking.firewall.interfaces."zt+".allowedTCPPorts = [ 8082 ]; # Only allow ZeroTier
  };
}
