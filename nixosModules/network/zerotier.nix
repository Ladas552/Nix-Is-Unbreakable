{ config, lib, ... }:

{
  options.custom = {
    zerotier.enable = lib.mkEnableOption "enable zerotier";
  };

  config = lib.mkIf config.custom.zerotier.enable {

    services.zerotierone = {
      enable = true;
      joinNetworks = [ "$(cat ${config.sops.secrets."mystuff/zero_net_id".path})" ];
      localConf = {
        settings = {
          softwareUpdate = "disable";
        };
      };
    };
  };
}
