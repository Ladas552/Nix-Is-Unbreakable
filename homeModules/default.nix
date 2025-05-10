{
  lib,
  config,
  meta,
  ...
}:

{
  imports = [
    ./chromium
    ./direnv
    ./emacs
    ./fastfetch
    ./thunderbird
    ./flameshot
    ./gh
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
    ./neovim
    ./nvf
    ./obs
    ./rofi
    ./qutebrowser
    ./lf
    ./ranger
    ./shell
    ./swaylock
    ./syncthing
    ./wpaperd
    ./vesktop
    ./vim
    ./yt-dlp
    ./zathura
  ];
  manual.manpages.enable = false;
  customhm = {
    shell.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
  };
}
