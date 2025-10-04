{ ... }:
{
  imports = [
    ./qemu.nix
    ./podman.nix
    ./incus.nix
    ./waydroid.nix
  ];
}
