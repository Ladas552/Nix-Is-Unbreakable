{ pkgs, inputs, lib, config, sops-nix, ... }:

{

  options = {
    secrets.enable = lib.mkEnableOption "enable secrets";
  };

  config = lib.mkIf config.secrets.enable {

    sops.defaultSopsFile = ../../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";

    sops.age.sshKeyPaths = [ "/home/ladas552/.ssh/NixToks" ];
    #sops.age.keyFile = "/home/ladas552/.config/sops/age/keys.txt";

    sops.secrets."mystuff/host_pwd".neededForUsers = true;
    sops.secrets."mystuff/host_pwd" = {};

    sops.secrets."mystuff/zero_net_id".neededForUsers = true;
    sops.secrets."mystuff/zero_net_id" = {};
  };
}
