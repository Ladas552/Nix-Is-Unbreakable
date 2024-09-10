{pkgs, lib, config, inputs, ...}:

{

  options.customhm = {
    mangohud.enable = lib.mkEnableOption "enable mangohud";
  };
  config = lib.mkIf config.customhm.mangohud.enable {
    programs.mangohud = {
      enable = true;
    };
  };
}
