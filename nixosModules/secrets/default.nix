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

    sops.age.sshKeyPaths =
      if config.custom.imp.enable then
        [ "/persist/home/${meta.user}/.ssh/NixToks" ]
      else
        [ "/home/${meta.user}/.ssh/NixToks" ];
    #sops.age.keyFile = "/home/ladas552/.config/sops/age/keys.txt";

    sops.secrets."mystuff/host_pwd".neededForUsers = true;
    sops.secrets."mystuff/host_pwd" = { };

  };
}
