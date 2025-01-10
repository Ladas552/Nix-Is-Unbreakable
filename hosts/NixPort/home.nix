{
  pkgs,
  pkgs-stable,
  inputs,
  meta,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  imports = [ ./../../homeModules ];

  customhm = {
    obs.enable = true;
    chromium.enable = true;
    direnv.enable = true;
    gh.enable = true;
    ghostty.enable = true;
    helix.enable = true;
    imv.enable = true;
    mpd.enable = true;
    mpv.enable = true;
    syncthing.enable = true;
    thunderbird.enable = true;
    lf.enable = true;
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
    #pkgs-stable
    vesktop
    inputs.ghostty.packages.x86_64-linux.default
    libreoffice-fresh
    shotcut
    imagemagick
    wl-clipboard
    candy-icons
    ffmpeg
    gst_all_1.gst-libav
    floorp
    hunspell
    hunspellDicts.en-us-large
    hunspellDicts.ru-ru
    keepassxc
    libqalculate
    lshw
    manix
    nuspell
    pamixer
    pavucontrol
    qbittorrent
    rofi-wayland
    telegram-desktop
    typst
    xarchiver
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
