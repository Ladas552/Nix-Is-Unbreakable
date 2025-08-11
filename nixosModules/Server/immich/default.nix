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
    # Caddy
    services.caddy.virtualHosts."immich.taila7a93b.ts.net" = {
      extraConfig = ''
        reverse_proxy localhost:2283
      '';
    };

    # modules
    services.immich = {
      enable = true;
      openFirewall = false; # Only allow specific ports for specific networks
      host = "127.0.0.1";
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
