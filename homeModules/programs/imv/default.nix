{ lib, config, ... }:

{

  options.customhm = {
    imv.enable = lib.mkEnableOption "enable imv";
  };
  config = lib.mkIf config.customhm.imv.enable {
    programs.imv = {
      enable = true;
    };
    home.file.".config/imv/config" = {
      source = ./config;
    };
  };
}
