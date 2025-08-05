{ config, lib, ... }:

{
  options.custom = {
    tailscale.enable = lib.mkEnableOption "enable tailscale";
  };

  config = lib.mkIf config.custom.tailscale.enable {
    # module
    services.tailscale = {
      enable = true;
      openFirewall = true;
    };
  };
}
