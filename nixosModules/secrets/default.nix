{
  lib,
  config,
  inputs,
  pkgs,
  meta,
  ...
}:

{

  options.custom = {
    secrets.enable = lib.mkEnableOption "enable secrets";
  };

  imports = [ inputs.sops-nix.nixosModules.sops ];

  config = lib.mkIf config.custom.secrets.enable {

    environment.systemPackages = [ pkgs.sops ];

    sops.defaultSopsFile = ../../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";

    sops.age.sshKeyPaths = [ "/home/${meta.user}/.ssh/NixToks" ];
    #sops.age.keyFile = "/home/ladas552/.config/sops/age/keys.txt";

    sops.secrets."mystuff/host_pwd".neededForUsers = true;
    sops.secrets."mystuff/host_pwd" = { };

    sops.secrets."mystuff/zero_net_id".neededForUsers = true;
    sops.secrets."mystuff/zero_net_id" = { };

    sops.secrets."mystuff/zero_net_nixtoks".neededForUsers = true;
    sops.secrets."mystuff/zero_net_nixtoks" = { };

    sops.secrets."mystuff/nextcloud".neededForUsers = true;
    sops.secrets."mystuff/nextcloud" = { };

    sops.secrets."mystuff/kavita".neededForUsers = true;
    sops.secrets."mystuff/kavita" = { };

    sops.secrets."mystuff/homepage".neededForUsers = true;
    sops.secrets."mystuff/homepage" = { };
  };
}
