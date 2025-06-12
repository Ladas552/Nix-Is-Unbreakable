{
  config,
  lib,
  meta,
  ...
}:

{
  options.custom = {
    openssh.enable = lib.mkEnableOption "enable openssh";
  };

  config = lib.mkIf config.custom.openssh.enable {

    # SSH connections
    services.gnome.gnome-keyring.enable = true;
    security.pam = {
      services.login.enableGnomeKeyring = true;
      # Can use ssh instead of password on system
      sshAgentAuth.enable = true;
    };
    # Makes my reboots hang on poweroff sometimes
    # services.sshguard.enable = true;

    programs.gnupg.agent = {
      enable = true;
      # enableSSHSupport = true;
    };

    programs.ssh.startAgent = true;
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      openFirewall = true;
      banner = "You shell not pass!";
      startWhenNeeded = true;
      settings = {
        # Password because I can't connect my Tablet for some reason
        PasswordAuthentication = false;
        AllowUsers = null;
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = lib.mkDefault "no"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
      };
    };

    home-manager.users."${meta.user}" = {
      programs.ssh = {
        enable = true;
        forwardAgent = true;
        addKeysToAgent = "yes";
        controlMaster = "auto";
        controlPersist = "10m";

        matchBlocks."${meta.user}" = {
          host = "${meta.host}";
          user = "${meta.user}";
          identityFile = [ "~/.ssh/NixToks" ];
        };

        matchBlocks."aur.archlinux.org" = {
          host = "aur.archlinux.org";
          user = "aur";
          identityFile = [ "~/.ssh/aur" ];
        };
      };
    };
  };
}
