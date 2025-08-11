{ config, lib, ... }:

{
  options.custom = {
    zerotier.enable = lib.mkEnableOption "enable zerotier";
  };

  config = lib.mkIf config.custom.zerotier.enable {
    # secrets
    sops.secrets."mystuff/zero_net_id".neededForUsers = true;
    sops.secrets."mystuff/zero_net_id" = { };

    sops.secrets."mystuff/zero_net_nixtoks".neededForUsers = true;
    sops.secrets."mystuff/zero_net_nixtoks" = { };

    # module
    services.zerotierone = {
      enable = true;
      joinNetworks = [ "$(cat ${config.sops.secrets."mystuff/zero_net_id".path})" ];
      localConf = {
        settings = {
          softwareUpdate = "disable";
        };
      };
    };
    networking.firewall.allowedTCPPorts = [ 9993 ];
  };
}
