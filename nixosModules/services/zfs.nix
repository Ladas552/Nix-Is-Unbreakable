{
  config,
  lib,
  meta,
  ...
}:
{
  options.custom = {
    zfs.enable = lib.mkEnableOption "enable zfs";
  };
  # NOTE: zfs datasets are created manually
  config = lib.mkIf config.custom.zfs.enable {
    # https://github.com/NixOS/nixpkgs/issues/378790
    # Zen kernel is affected too, so I just use lts for a while lol
    nixpkgs.config.allowBroken = true;
    # Stolen from @iynaix and @xarvex, like the whole thing
    boot = {
      supportedFilesystems.zfs = true;
      zfs = {
        devNodes =
          if config.hardware.cpu.intel.updateMicrocode then "/dev/disk/by-id" else "/dev/disk/by-partuuid";
      };
    };
    services.zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };
    # standardized filesystem layo
    fileSystems = {
      "/" = {
        device = "zroot/root";
        fsType = "zfs";
        neededForBoot = true;
      };
      # boot partitin
      "/boot" = {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
      };
      "/nix" = {
        device = "zroot/nix";
        fsType = "zfs";
      };
      # by default, /tmp is not a tmpfs on nixos as some build artifacts can be stored there
      # when using / as a small tmpfs for impermanence, /tmp can then easily run out of space,
      # so create a dataset for /tmp to prevent this
      # /tmp is cleared on boot via `boot.tmp.cleanOnBoot = true;
      "/tmp" = {
        device = "zroot/tmp";
        fsType = "zfs";
      };
      # cache are files that should be persisted, but not to snapshot
      # e.g. npm, cargo cache etc, that could always be redownload
      "/cache" = {
        device = "zroot/cache";
        fsType = "zfs";
        neededForBoot = true;
      };
    };
    # https://github.com/openzfs/zfs/issues/10891
    systemd.services = {
      systemd-udev-settle.enable = false;
    };
    services.sanoid = {
      enable = true;
      datasets = {
        "zroot/persist" = {
          hourly = 50;
          daily = 15;
          weekly = 3;
          monthly = 1;
        };
      };
    };
    home-manager.users.${meta.user}.home.shellAliases = {
      zfs-list = "zfs list -o name,used,avail,compressratio,mountpoint";
    };
  };
}
