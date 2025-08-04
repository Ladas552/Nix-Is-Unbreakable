{
  config,
  lib,
  ...
}:

{
  options.custom = {
    miniflux.enable = lib.mkEnableOption "enable miniflux";
  };

  config = lib.mkIf config.custom.miniflux.enable {

    services.miniflux = {
      enable = true;
      adminCredentialsFile = "${config.sops.templates."miniflux-admin-credentials".path}";
      config = {
        LISTEN_ADDR = "${config.custom.homelab.ip}:8067";
        CREATE_ADMIN = "1";
        LOG_DATE_TIME = "1";

        FETCH_BILIBILI_WATCH_TIME = "1";
        FETCH_NEBULA_WATCH_TIME = "1";
        FETCH_ODYSEE_WATCH_TIME = "1";
        FETCH_YOUTUBE_WATCH_TIME = "1";

      };
    };
    networking.firewall.interfaces.ztcfwrb2q6.allowedTCPPorts = [ 8067 ]; # Only allow ZeroTier
  };
}
