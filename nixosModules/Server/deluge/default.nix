{
  config,
  lib,
  meta,
  ...
}:

{
  options.custom = {
    deluge.enable = lib.mkEnableOption "enable deluge";
  };

  config = lib.mkIf config.custom.deluge.enable {

    services.deluge = {
      enable = true;
      web.enable = true;
      user = meta.user;
    };
    networking.firewall.interfaces."zt+".allowedTCPPorts = [ 8112 ]; # Only allow ZeroTier
  };
}
