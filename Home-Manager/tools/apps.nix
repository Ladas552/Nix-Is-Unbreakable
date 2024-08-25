{ config, pkgs, inputs, ... }:

{
  imports = [
    ./fastfetch
    ./fish
    ./git
    ./kitty
    ./mpd
    ./mpv
    #   ./nixvim
    ./ranger
    ./vim
    # ./qutebrowser
    #   ./emacs
  ];
  programs = {
    zathura = {
      enable = true;
    };
    btop = {
      enable = true;
    };
    fd = {
      enable = true;
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
    mangohud = {
      enable = true;
    };
    yt-dlp = {
      enable = true;
    };
    ripgrep = {
      enable = true;
    };
    imv = {
      enable = true;
    };
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vkcapture
        input-overlay
        droidcam-obs
      ];
    };
    # jujutsu = {
    #   enable = true;
    # };
  };
  services = {
    flameshot = {
      enable = true;
    };
    syncthing = {
      enable = true;
      tray.enable = true;
    };
  };
}
