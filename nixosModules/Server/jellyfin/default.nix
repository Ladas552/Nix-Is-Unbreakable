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
    networking.firewall.interfaces."zt+".allowedTCPPorts = [
      8096
      8920
    ]; # Only allow ZeroTier
  };
}
