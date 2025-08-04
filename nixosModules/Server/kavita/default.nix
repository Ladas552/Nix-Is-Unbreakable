{
  config,
  lib,
  ...
}:

{
  options.custom = {
    kavita.enable = lib.mkEnableOption "enable kavita";
  };

  config = lib.mkIf config.custom.kavita.enable {

    services.kavita = {
      enable = true;
      tokenKeyFile = config.sops.secrets."mystuff/kavita".path;
    };
    networking.firewall.interfaces.ztcfwrb2q6.allowedTCPPorts = [ 5000 ]; # Only allow ZeroTier
  };
}
