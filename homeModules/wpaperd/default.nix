{ lib, config, ... }:

{

  options.customhm = {
    wpaperd.enable = lib.mkEnableOption "enable wpaperd";
  };
  config = lib.mkIf config.customhm.wpaperd.enable {
    programs.wpaperd = {
      enable = true;
      settings = {
        eDP-1 = {
          path = "${config.xdg.userDirs.pictures}/backgrounds/backs";
          sorting = "random";
          duration = "10m";
        };
      };
    };
  };
}
