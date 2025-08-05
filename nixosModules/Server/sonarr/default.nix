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
      settings = {
        server = {
          urlbase = config.custom.homelab.ip;
          port = 8989;
          bindaddress = "*";
        };
      };
    };
    networking.firewall.interfaces.ztcfwrb2q6.allowedTCPPorts = lib.mkIf config.custom.zerotier.enable [
      8989
    ]; # Only allow ZeroTier
    networking.firewall.interfaces.tailscale0.allowedTCPPorts =
      lib.mkIf config.custom.tailscale.enable
        [ 8989 ]; # Only allow Tailscale
  };
}
