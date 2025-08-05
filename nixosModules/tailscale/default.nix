{ config, lib, ... }:

{
  options.custom = {
    tailscale.enable = lib.mkEnableOption "enable tailscale";
  };

  config = lib.mkIf config.custom.tailscale.enable {
    # homelab ip with tailscale, conflicts with zerotier
    custom.homelab.ip = "100.74.112.27";

    # secrets
    sops.secrets."mystuff/tailnet".neededForUsers = true;
    sops.secrets."mystuff/tailnet" = { };

    # module
    services.tailscale = {
      enable = true;
      openFirewall = true;
      # expires after 90 days
      authKeyFile = "${config.sops.secrets."mystuff/tailnet".path}";
    };
  };
}
