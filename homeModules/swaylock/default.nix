{ lib, config, ... }:

{

  options.customhm = {
    swaylock.enable = lib.mkEnableOption "enable swaylock";
  };
  config = lib.mkIf config.customhm.swaylock.enable {
    programs.swaylock = {
      enable = true;
    };
  };
}
