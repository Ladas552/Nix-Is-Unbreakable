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
      host = "10.144.32.1";
      machine-learning.enable = false; # Doesn't seem to work on my nvidia 860m
    };
    networking.firewall.interfaces."zt+".allowedTCPPorts = [ 2283 ]; # Only allow ZeroTier
  };
}
