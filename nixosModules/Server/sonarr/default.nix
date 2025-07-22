{
  config,
  lib,
  meta,
  ...
}:

{
  options.custom = {
    sonarr.enable = lib.mkEnableOption "enable sonarr";
  };

  config = lib.mkIf config.custom.sonarr.enable {

    services.sonarr = {
      enable = true;
      user = meta.user;
      settings = {
        server = {
          urlbase = config.custom.homelab.ip;
          port = 8989;
          bindaddress = "*";
        };
      };
    };
    networking.firewall.interfaces."zt+".allowedTCPPorts = [ 8989 ]; # Only allow ZeroTier
  };
}
