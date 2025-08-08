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
    # secrets
    sops.secrets."mystuff/kavita".neededForUsers = true;
    sops.secrets."mystuff/kavita" = { };
    # module
    services.kavita = {
      enable = true;
      tokenKeyFile = config.sops.secrets."mystuff/kavita".path;
    };
    networking.firewall.interfaces.ztcfwrb2q6.allowedTCPPorts = lib.mkIf config.custom.zerotier.enable [
      5000
    ]; # Only allow ZeroTier
    networking.firewall.interfaces.tailscale0.allowedTCPPorts =
      lib.mkIf config.custom.tailscale.enable
        [ 5000 ]; # Only allow Tailscale
    users.users."kavita".extraGroups = [ "media" ];
  };
}
