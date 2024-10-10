{ lib, ... }:

{
  imports = [
    ./chromium
    ./direnv
    ./emacs
    ./fastfetch
    ./flameshot
    ./ghostty
    ./git
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
    ./tui-tools
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
    yazi.enable = lib.mkDefault true;
    vim.enable = lib.mkDefault true;
    tui-tools.enable = lib.mkDefault true;
    fastfetch.enable = lib.mkDefault true;
  };
}
