{pkgs, lib, config, inputs, ...}:

{

  options.customhm = {
    zathura.enable = lib.mkEnableOption "enable zathura";
  };
  config = lib.mkIf config.customhm.zathura.enable {
    programs.zathura = {
      enable = true;
    };
  };
}
