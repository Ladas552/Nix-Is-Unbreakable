{
  config,
  lib,
  meta,
  ...
}:

{
  options.custom = {
    ncps.enable = lib.mkEnableOption "enable ncps, proxy cache across all systems on the network";
  };

  config = lib.mkIf config.custom.ncps.enable {

    services.ncps = {
      enable = true;
      cache.hostName = "${config.custom.homelab.ip}";
      upstream = {
        publicKeys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
        caches = [ "https://cache.nixos.org" ];
      };
    };
    networking.firewall.interfaces.ztcfwrb2q6.allowedTCPPorts = [ 8501 ]; # Only allow ZeroTier
  };
}
