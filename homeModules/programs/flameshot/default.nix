{pkgs, lib, config, inputs, ...}:

{

  options.customhm = {
    flameshot.enable = lib.mkEnableOption "enable flameshot";
  };
  config = lib.mkIf config.customhm.flameshot.enable {
    services.flameshot = {
      enable = true;
      settings = {
        General = {
          showHelp = false;
          showDesktopNotification = false;
        };
      };
    };
  };
}
