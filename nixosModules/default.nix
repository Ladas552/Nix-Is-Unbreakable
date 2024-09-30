{ lib, ... }:

{

  imports = [
    ./desktop/fonts.nix
    ./desktop/games.nix
    ./desktop/libinput.nix
    ./desktop/lightdm.nix
    ./desktop/ly.nix
    ./desktop/minecraft.nix
    ./desktop/otd.nix
    ./desktop/thunar.nix
    ./desktop/sessions
    ./desktop/stilyx
    ./general.nix
    ./network/bluetooth.nix
    ./network/openssh.nix
    ./network/rtorrent.nix
    ./network/zerotier.nix
    ./network/kde-connect.nix
    ./secrets/sops.nix
    ./services/clamav.nix
    ./services/ld-nix.nix
    ./services/nix-helper.nix
    ./services/plymouth.nix
    ./services/powermanager.nix
    ./services/printers.nix
    ./services/sound.nix
    ./services/virtualisation.nix
  ];
  custom = {
    general.enable = lib.mkDefault true;
    nix-helper.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
    sounds.enable = lib.mkDefault true;
    secrets.enable = lib.mkDefault true;
    openssh.enable = lib.mkDefault true;
    zerotier.enable = lib.mkDefault true;
  };
}
