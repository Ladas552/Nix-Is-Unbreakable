{ config, lib, pkgs, ...}:


{
  options.custom = {
    touchpad.enable = lib.mkEnableOption "enable touchpad";
  };

  config = lib.mkIf config.custom.touchpad.enable {
    services.libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        scrollMethod = "edge";
        disableWhileTyping = false;
        clickMethod = "clickfinger";
      };
      mouse = {
        middleEmulation = false;
      };
    };
  };
}
