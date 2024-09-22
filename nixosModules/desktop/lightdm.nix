{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom = {
    lightdm.enable = lib.mkEnableOption "enable lightdm";
  };

  config = lib.mkIf config.custom.lightdm.enable {
    services = {
      xserver = {
        desktopManager.xterm.enable = false;
        displayManager.lightdm = {
          enable = true;
          greeters.slick.enable = true;
          greeters.slick.theme.name = "Zukitre-dark";
        };
        # Numlock on start because I use numpad
        displayManager.setupCommands = ''
          ${pkgs.numlockx}/bin/numlockx on
        '';
      };
    };
  };
}
