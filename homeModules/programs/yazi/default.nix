{ lib, config, ... }:

{

  options.customhm = {
    yazi.enable = lib.mkEnableOption "enable yazi";
  };
  config = lib.mkIf config.customhm.yazi.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      shellWrapperName = "mc";
    };
  };
}
