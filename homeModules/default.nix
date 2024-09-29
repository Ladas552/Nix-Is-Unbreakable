{ lib, ... }:

{
  imports = [
    ./chromium
    ./emacs
    ./fastfetch
    ./shell
    ./flameshot
    ./ghostty
    ./git
    ./tui-tools
    ./imv
    ./kitty
    ./mangohud
    ./mako
    ./mpd
    ./mpv
    ./nixvim
    ./obs
    ./qutebrowser
    ./ranger
    ./syncthing
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
