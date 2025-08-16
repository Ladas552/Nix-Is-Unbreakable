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
    # secrets
    sops.secrets."mystuff/nextcloud".neededForUsers = true;
    sops.secrets."mystuff/nextcloud" = { };

    networking.firewall.interfaces.ztcfwrb2q6.allowedTCPPorts = lib.mkIf config.custom.zerotier.enable [
      8080
    ]; # Only allow ZeroTier
    networking.firewall.interfaces.tailscale0.allowedTCPPorts =
      lib.mkIf config.custom.tailscale.enable
        [ 8080 ]; # Only allow Tailscale

    # Proxy
    # Nextcloud got hard dependency on nginx, i tried to remove it before, it worked, but didn't remove nginx outright
    # https://github.com/Ladas552/Nix-Is-Unbreakable/commit/2795a648c92b986df438787737add83f7961bfa6
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

    users.users."nextcloud".extraGroups = [ "media" ];

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
