{ config, lib, pkgs, ...}:

{
  options = {
    ly.enable = lib.mkEnableOption "enable ly";
  };

  config = lib.mkIf config.ly.enable {
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
