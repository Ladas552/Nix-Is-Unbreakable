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

    # caddy
    services.caddy.virtualHosts."${config.services.nextcloud.hostName}:8080".listenAddresses = [
      "0.0.0.0"
    ];
    networking.firewall.interfaces.ztcfwrb2q6.allowedTCPPorts = lib.mkIf config.custom.zerotier.enable [
      8080
    ]; # Only allow ZeroTier
    networking.firewall.interfaces.tailscale0.allowedTCPPorts =
      lib.mkIf config.custom.tailscale.enable
        [ 8080 ]; # Only allow Tailscale

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
