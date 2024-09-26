{ lib, config, ... }:

{

  options.custom = {
    secrets.enable = lib.mkEnableOption "enable secrets";
  };

  config = lib.mkIf config.custom.secrets.enable {

    sops.defaultSopsFile = ../../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";

    sops.age.sshKeyPaths = [ "/home/ladas552/.ssh/NixToks" ];
    #sops.age.keyFile = "/home/ladas552/.config/sops/age/keys.txt";

    sops.secrets."mystuff/host_pwd".neededForUsers = true;
    sops.secrets."mystuff/host_pwd" = { };

    sops.secrets."mystuff/zero_net_id".neededForUsers = true;
    sops.secrets."mystuff/zero_net_id" = { };

    sops.secrets."mystuff/syncthing/devices/phone".neededForUsers = true;
    sops.secrets."mystuff/syncthing/devices/phone" = { };

    sops.secrets."mystuff/syncthing/devices/tablet".neededForUsers = true;
    sops.secrets."mystuff/syncthing/devices/tablet" = { };

    sops.secrets."mystuff/syncthing/folders/Norg".neededForUsers = true;
    sops.secrets."mystuff/syncthing/folders/Norg" = { };

    sops.secrets."mystuff/syncthing/folders/Share".neededForUsers = true;
    sops.secrets."mystuff/syncthing/folders/Share" = { };

    sops.secrets."mystuff/syncthing/folders/keepass".neededForUsers = true;
    sops.secrets."mystuff/syncthing/folders/keepass" = { };
  };
}
