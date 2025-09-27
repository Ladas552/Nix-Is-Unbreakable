{
  config,
  lib,
  inputs,
  ...
}:

{
  options.custom = {
    imp.enable = lib.mkEnableOption "enable impermanence";
  };
  imports = [
    ./users.nix
    inputs.impermanence.nixosModules.impermanence
  ];
  config = lib.mkIf config.custom.imp.enable {
    # persist mount
    fileSystems."/persist" = {
      device = "zroot/persist";
      fsType = "zfs";
      neededForBoot = true;
    };
    # replace the root mount with tmpfs
    # fileSystems."/" = lib.mkForce {
    #   device = "tmpfs";
    #   fsType = "tmpfs";
    #   neededForBoot = true;
    #   options = [
    #     "defaults"
    #     # whatever size feels comfortable, smaller is better
    #     "size=1G"
    #     "mode=755"
    #   ];
    # };

    # clean /tmp
    boot.tmp.cleanOnBoot = true;
  };
}
