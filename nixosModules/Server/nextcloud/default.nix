{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom = {
    nextcloud.enable = lib.mkEnableOption "enable nextcloud";
  };

  config = lib.mkIf config.custom.nextcloud.enable {
    networking.firewall.interfaces."zt+".allowedTCPPorts = [ 8080 ]; # Only allow ZeroTier

    # Proxy
    services.nginx = {
      enable = true;
      virtualHosts = {
        "${config.services.nextcloud.hostName}" = {
          listen = [
            {
              addr = "0.0.0.0";
              port = 8080;
            }
          ];
        };
      };

    };

    services.postgresql = {
      enable = true;
      ensureDatabases = [ "nextcloud" ];
      ensureUsers = [
        {
          name = "nextcloud";
          ensureDBOwnership = true;
        }
      ];
    };
    systemd.services."nextcloud-setup" = {
      requires = [ "postgresql.service" ];
      after = [ "postgresql.service" ];
    };

    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud31;
      configureRedis = true;
      maxUploadSize = "50G";
      hostName = "nextcloud.ladas552.me";
      settings.trusted_domains = [ "${config.custom.homelab.ip}" ];
      config = {
        dbtype = "pgsql";
        dbuser = "nextcloud";
        dbhost = "/run/postgresql";
        dbname = "nextcloud";
        adminuser = "ladas552";
        adminpassFile = config.sops.secrets."mystuff/nextcloud".path;
      };
    };
  };
}
