{ config, lib, pkgs, inputs, ...}:

{

  imports = [
    ./defaultc.nix
    ./desktop/fonts.nix
    ./desktop/games.nix
    ./desktop/minecraft.nix
    ./desktop/libinput.nix
    ./desktop/lightdm.nix
    ./desktop/otd.nix
    ./desktop/sessions/xfce.nix
    ./desktop/sessions/bspwm.nix
    ./desktop/ly.nix
    ./network/bluetooth.nix
    ./network/openssh.nix
    ./network/zerotier.nix
    ./secrets/sops.nix
    ./services/clamav.nix
    ./services/ld-nix.nix
    ./services/nix-helper.nix
    ./services/plymouth.nix
    ./services/printers.nix
    ./services/sound.nix
    ./services/virtualisation.nix
    ./services/powermanager.nix
    ./desktop/stilyx
    ./network/rtorrent.nix
  ];
  custom = {
    defaultc.enable = lib.mkDefault true;
    nix-helper.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
    sounds.enable = lib.mkDefault true;
    secrets.enable = lib.mkDefault true;
  };
}
