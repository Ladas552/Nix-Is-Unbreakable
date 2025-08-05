{
  config,
  lib,
  ...
}:

{
  options.custom = {
    jellyfin.enable = lib.mkEnableOption "enable jellyfin";
  };

  config = lib.mkIf config.custom.jellyfin.enable {

    services.jellyfin = {
      enable = true;
    };
    networking.firewall.interfaces.ztcfwrb2q6.allowedTCPPorts = lib.mkIf config.custom.zerotier.enable [
      8096
      8920
    ]; # Only allow ZeroTier
    networking.firewall.interfaces.tailscale0.allowedTCPPorts =
      lib.mkIf config.custom.tailscale.enable
        [
          8096
          8920
        ]; # Only allow Tailscale
  };
}
