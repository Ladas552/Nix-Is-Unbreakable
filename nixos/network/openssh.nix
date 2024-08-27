{ config, lib, pkgs, ...}:

{
  options = {
    openssh.enable = lib.mkEnableOption "enable openssh";
  };

  config = lib.mkIf config.openssh.enable {

    # SSH connections
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      banner = "You shell not pass!";
      startWhenNeeded = true;
      settings = {
        PasswordAuthentication = false;
        AllowUsers = null;
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };
  };
}
