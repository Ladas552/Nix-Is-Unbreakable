{ config, lib, ... }:
{
  options.custom = {
    pam.enable = lib.mkEnableOption "enable pam";
  };

  config = lib.mkIf config.custom.pam.enable {
    # Enable Swaylock to unlock the screen
    security.pam.services.swaylock = { };
  };
}
