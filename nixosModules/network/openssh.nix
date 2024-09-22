{ config, lib, ... }:

{
  options.custom = {
    openssh.enable = lib.mkEnableOption "enable openssh";
  };

  config = lib.mkIf config.custom.openssh.enable {

    # SSH connections
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;

    programs.gnupg.agent = {
      enable = true;
      #     enableSSHSupport = true;
    };

    programs.ssh.startAgent = true;

    services.openssh = {
      enable = true;
      ports = [ 22 ];
      openFirewall = true;
      banner = "You shell not pass!";
      startWhenNeeded = true;
      settings = {
        PasswordAuthentication = false;
        AllowUsers = null;
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = lib.mkDefault "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };
  };
}
