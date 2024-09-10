{ config, lib, pkgs, ...}:


{
  options.custom = {
    libinput.enable = lib.mkEnableOption "enable libinput";
  };

  config = lib.mkIf config.custom.libinput.enable {
    services.libinput = {
      enable = true;
      touchpad = {
        tapping = true;
        naturalScrolling = true;
        scrollMethod = "edge";
        disableWhileTyping = false;
        clickMethod = "buttonareas";
      };
      mouse = {
        middleEmulation = false;
      };
    };
  };
}
