{ config, lib, pkgs, pkgs-stable, ...}:

{
  options.custom = {
    zerotier.enable = lib.mkEnableOption "enable zerotier";
  };

  config = lib.mkIf config.custom.zerotier.enable {

    services.zerotierone = {
      #     package = pkgs-stable.zerotierone;
      enable = true;
      joinNetworks = [ 
        "$(cat ${config.sops.secrets."mystuff/zero_net_id".path})"
      ];
      localConf = { 
        settings = { 
          softwareUpdate = "disable";
        };
      };
    };
  };
}
