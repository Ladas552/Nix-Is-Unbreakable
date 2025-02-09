{
  config,
  lib,
  ...
}:

{
  options.custom = {
    firewall.enable = lib.mkEnableOption "enable firewall";
  };

  config = lib.mkIf config.custom.firewall.enable {
    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [ 9993 ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    networking.firewall.enable = true;
  };
}
