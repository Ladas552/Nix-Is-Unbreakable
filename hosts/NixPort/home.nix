{
  pkgs,
  inputs,
  meta,
  ...
}:

{
  # Hom Manager needs a bit of information about you and the paths it should
  # manage.

  imports = [ ./../../homeModules ];

  customhm = {
    # nixvim.enable = true;
    neovim.enable = true;
    emacs.enable = true;
    chromium.enable = true;
    direnv.enable = true;
    fastfetch.enable = true;
    gh.enable = true;
    ghostty.enable = true;
    helix.enable = true;
    imv.enable = true;
    lf.enable = true;
    mpd.enable = true;
    mpv.enable = true;
    obs.enable = true;
    rofi.enable = true;
    syncthing.enable = true;
    thunderbird.enable = true;
    yt-dlp.enable = true;
    zathura.enable = true;
  };

  # Me
  home.username = "${meta.user}";
  home.homeDirectory = "/home/${meta.user}";
  # Don't change
  home.stateVersion = "24.11"; # Please read the comment before changing.
  # Standalone Packages for user
  home.packages = with pkgs; [
    # waydroid script
    lzip

    vesktop
    libreoffice-fresh
    # shotcut
    imagemagick
    wl-clipboard
    ffmpeg
    gst_all_1.gst-libav
    floorp
    hunspell
    hunspellDicts.en-us-large
    hunspellDicts.ru-ru
    keepassxc
    libqalculate
    lshw
    pamixer
    pavucontrol
    qbittorrent
    telegram-desktop
    typst
    xarchiver
    zotero
  ];

  # Environment and Dependencies
  xdg = {
    enable = true;
  };

  # Environmental Variables
  home.sessionVariables = {
    BROWSER = "floorp";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
