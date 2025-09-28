{
  lib,
  config,
  meta,
  ...
}:

{
  imports = [
    ./chawan
    ./chromium
    ./direnv
    ./emacs
    ./fastfetch
    ./foot
    ./flameshot
    ./gh
    ./ghostty
    ./git
    ./helix
    ./imv
    ./kitty
    ./lf
    ./librewolf
    ./mako
    ./mangohud
    ./mpd
    ./mpv
    ./neovide
    ./neovim
    ./nixvim
    ./nvf
    ./obs
    ./qutebrowser
    ./ranger
    ./rofi
    ./shell
    ./swaylock
    ./syncthing
    ./thunderbird
    ./vesktop
    ./vim
    ./wpaperd
    ./yt-dlp
    ./zathura
    ./Nixos/impermanence
  ];
  manual.manpages.enable = false;
  customhm = {
    shell.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
  };
}
