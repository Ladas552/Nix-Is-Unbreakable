{
  config,
  meta,
  lib,
  inputs,
  ...
}:
let
  cfg = config.custom.imp;
  cfghm = config.home-manager.users."${meta.user}".customhm.imp;
in
{
  options.custom = {
    imp.enable = lib.mkEnableOption "enable impermanence";
    # options to put directories in, persistence but shortened
    # stolen from @iynaix
    imp = {
      root = {
        directories = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Directories to persist in root filesystem";
        };
        files = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Files to persist in root filesystem";
        };
        cache = {
          directories = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "Directories to persist, but not to snapshot";
          };
          files = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "Files to persist, but not to snapshot";
          };
        };
      };
      home = {
        directories = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Directories to persist in home directory";
        };
        files = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Files to persist in home directory";
        };
      };
    };
  };
  imports = [
    ./users.nix
    ./persist.nix
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
    # wipes everything if you don't have proper persists, be warned
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

    # essential persists
    environment.persistence = {
      "/persist" = {
        hideMounts = true;
        files = lib.unique cfg.root.files;
        directories = lib.unique (
          [
            "/var/log"
            "/var/lib/nixos"
          ]
          ++ cfg.root.directories
        );
        users."${meta.user}" = {
          files = lib.unique cfghm.home.files;
          directories = lib.unique ([ ] ++ cfg.home.directories ++ cfghm.home.directories);
        };
      };
      "/cache" = {
        hideMounts = true;
        files = lib.unique cfg.root.cache.files;
        directories = lib.unique cfg.root.cache.directories;
        users."${meta.user}" = {
          files = lib.unique cfghm.home.cache.files;
          directories = lib.unique ([ ] ++ cfghm.home.cache.directories);
        };
      };
    };
  };
}
