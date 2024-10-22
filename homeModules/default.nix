{ lib, ... }:

{
  imports = [
    ./chromium
    ./direnv
    ./emacs
    ./fastfetch
    ./thunderbird
    ./flameshot
    ./ghostty
    ./git
    ./helix
    ./imv
    ./kitty
    ./mako
    ./mangohud
    ./mpd
    ./mpv
    ./nixvim
    ./obs
    ./qutebrowser
    ./ranger
    ./shell
    ./swaylock
    ./syncthing
    ./wpaperd
    ./vim
    ./yazi
    ./yt-dlp
    ./zathura
  ];

  customhm = {
    nixvim.enable = lib.mkDefault true;
    shell.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    ranger.enable = lib.mkDefault true;
  };
}
