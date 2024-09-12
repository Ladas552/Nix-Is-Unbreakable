{pkgs, lib, config, inputs, ...}:

{
  imports = [
    ./btop
    ./emacs
    ./fastfetch
    ./fd
    ./fish
    ./flameshot
    ./fzf
    ./git
    ./imv
    ./kitty
    ./mangohud
    ./mpd
    ./mpv
    ./nixvim
    ./obs
    ./qutebrowser
    ./ranger
    ./ripgrep
    ./syncthing
    ./vim
    ./yt-dlp
    ./zathura
  ];
}
