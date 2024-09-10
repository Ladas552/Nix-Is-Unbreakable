{pkgs, lib, config, inputs, ...}:

{

  options.customhm = {
    imv.enable = lib.mkEnableOption "enable imv";
  };
  config = lib.mkIf config.customhm.imv.enable {
    programs.imv = {
      enable = true;
    };
  };
}
