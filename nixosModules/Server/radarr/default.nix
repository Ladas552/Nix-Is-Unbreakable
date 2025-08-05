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
    networking.firewall.interfaces.ztcfwrb2q6.allowedTCPPorts = lib.mkIf config.custom.zerotier.enable [
      7878
    ]; # Only allow ZeroTier
    networking.firewall.interfaces.tailscale0.allowedTCPPorts =
      lib.mkIf config.custom.tailscale.enable
        [ 7878 ]; # Only allow Tailscale
  };
}
