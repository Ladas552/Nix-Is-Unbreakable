{pkgs, lib, config, inputs, ...}:

{
  imports = [
    ./zathura
    ./btop
    ./fd
    ./fzf
    ./mangohud
    ./yt-dlp
    ./ripgrep
    ./imv
    ./flameshot
    ./fastfetch
    ./fish
    ./git
    ./kitty
    ./mpd
    ./mpv
    ./nixvim
    ./ranger
    ./vim
    ./qutebrowser
    ./emacs
    ./obs
  ];
}
