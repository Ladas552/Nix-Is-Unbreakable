{ pkgs, lib }:
# I have this nasty bug that corrupts my /boot, I need to fix it
# but here is a script I use to not do it manually everytime
# Do this all in sudo tho
pkgs.writeShellScriptBin "restore.sh" # bash
  ''
    mkfs.vfat /dev/nvme0n1p5 -n NIXBOOT
    zpool import zroot -f
    mount -t zfs zroot/root /mnt
    mount /dev/nvme0n1p5 /mnt/boot
    mount -t zfs zroot/nix /mnt/nix
    mount -t zfs zroot/tmp /mnt/tmp
    mount -t zfs zroot/cache /mnt/cache
    nixos-install --flake "github:Ladas552/Nix-Is-Unbreakable#NixPort"
  ''
