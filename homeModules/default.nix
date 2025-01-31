{ lib, meta, ... }:

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
    ./obs
    ./rofi
    ./qutebrowser
    ./lf
    ./ranger
    ./shell
    ./swaylock
    ./syncthing
    ./wpaperd
    ./vim
    ./yt-dlp
    ./zathura
  ];
  manual.manpages.enable = false;
  customhm = {
    nixvim = lib.mkDefault {
      enable = true;
      options = true;
      keymaps = true;
      colorschemes.catppuccin = true;
      plugins = {
        NixToks = (!meta.isTermux);
        NixMux = meta.isTermux;
        Neorg = true;
      };
    };
    shell.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    ranger.enable = lib.mkDefault true;
  };
}
