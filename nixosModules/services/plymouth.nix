{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom = {
    plymouth.enable = lib.mkEnableOption "enable plymouth";
  };

  config = lib.mkIf config.custom.plymouth.enable {
    #Doesn't really work
    # boot.kernelParams = [
    #   "quiet"
    #   "loglevel=3"
    #   "udev.log-priority=3"
    # ];
    #eyecandy on boot, my boot is too fast tho
    boot.plymouth = {
      enable = true;
      #theme = "nixos-bgrt";
      #themePackages = [ pkgs.nixos-bgrt-plymouth ];
      extraConfig = ''
        # [Daemon]
        ShowDelay=0
        [Unit]
        Conflicts=plymouth-quit.service
        After=plymouth-quit.service rc-local.service plymouth-start.service systemd-user-sessions.service
        OnFailure=plymouth-quit.service
      '';
      # if something doesn't work, try to uncomment this
      #    [Service]
      #    ExecStartPost=-${pkgs.coreutils}/bin/sleep 30
      #    ExecStartPost=-${pkgs.plymouth}/bin/plymouth quit --retain-splash
      #    ";
    };
  };
}
