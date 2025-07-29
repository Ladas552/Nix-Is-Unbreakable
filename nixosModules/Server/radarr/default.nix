{
  config,
  lib,
  meta,
  ...
}:

{
  options.custom = {
    radarr.enable = lib.mkEnableOption "enable radarr";
  };

  config = lib.mkIf config.custom.radarr.enable {

    services.radarr = {
      enable = true;
      settings = {
        server = {
          urlbase = config.custom.homelab.ip;
          port = 7878;
          bindaddress = "*";
        };
      };
    };
    networking.firewall.interfaces."zt+".allowedTCPPorts = [ 7878 ]; # Only allow ZeroTier
  };
}
