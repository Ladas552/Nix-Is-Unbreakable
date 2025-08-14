{
  config,
  lib,
  inputs,
  ...
}:

{
  options.custom = {
    immich.enable = lib.mkEnableOption "enable immich";
  };

  config = lib.mkIf config.custom.immich.enable {
    # modules
    services.immich = {
      enable = true;
      package = inputs.nixpkgs-immich.outputs.legacyPackages.x86_64-linux.immich;
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
