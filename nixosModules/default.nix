{ lib, ... }:

{

  imports = [
    ./Desktops
    ./Server
    ./Virtualisation
    ./bluetooth
    ./cache
    ./clamav
    ./firewall
    ./fonts
    ./games
    ./general
    ./grub
    ./systemd-boot
    ./kde-connect
    ./libinput
    ./lightdm
    ./nix
    ./nix-helper
    ./nix-ld
    ./openssh
    ./otd
    ./pipewire
    ./plymouth
    ./printers
    ./secrets
    ./stylix
    ./thunar
    ./tlp
    ./xkb
    ./zerotier
    ./zfs
  ];
  custom = {
    cache.enable = lib.mkDefault true;
    general.enable = lib.mkDefault true;
    nix.enable = lib.mkDefault true;
    nix-helper.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
    pipewire.enable = lib.mkDefault true;
    secrets.enable = lib.mkDefault true;
    openssh.enable = lib.mkDefault true;
    firewall.enable = lib.mkDefault true;
    greetd.enable = lib.mkDefault true;

};
}
