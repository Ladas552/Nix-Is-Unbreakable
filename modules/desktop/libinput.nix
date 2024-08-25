{ config, lib, pkgs, ...}:


{
  options = {
    touchpad.enable = lib.mkEnableOption "enable touchpad";
  };

  config = lib.mkIf config.touchpad.enable {
    services.libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        scrollMethod = "edge";
        disableWhileTyping = false;
        clickMethod = "clickfinger";
      };
    };
  };
}
