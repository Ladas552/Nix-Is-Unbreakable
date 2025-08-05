{
  config,
  lib,
  ...
}:

{
  options.custom = {
    immich.enable = lib.mkEnableOption "enable immich";
  };

  config = lib.mkIf config.custom.immich.enable {

    services.immich = {
      enable = true;
      openFirewall = false; # Only allow specific ports for specific networks
      host = "${config.custom.homelab.ip}";
      machine-learning.enable = false; # Doesn't seem to work on my nvidia 860m
    };
    networking.firewall.interfaces.ztcfwrb2q6.allowedTCPPorts = lib.mkIf config.custom.zerotier.enable [
      2283
    ]; # Only allow ZeroTier
    networking.firewall.interfaces.tailscale0.allowedTCPPorts =
      lib.mkIf config.custom.tailscale.enable
        [ 2283 ]; # Only allow Tailscale
  };
}
