{ config, lib, ... }:

{
  options.custom = {
    ly.enable = lib.mkEnableOption "enable ly";
  };

  config = lib.mkIf config.custom.ly.enable {
    services.displayManager.ly = {
      enable = true;
      settings = {
        bigclock = "en";
        default_input = "password";
        numlock = true;
        xinitrc = null;
      };
    };
  };
}
