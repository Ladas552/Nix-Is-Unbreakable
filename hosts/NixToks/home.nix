{
  pkgs,
  meta,
  ...
}:

{

  imports = [ ./../../homeModules ];

  customhm = {
    # neovim.enable = true;
    nixvim.enable = true;
    # nvf.enable = true;
    direnv.enable = true;
    fastfetch.enable = true;
    gh.enable = true;
    # helix.enable = true;
    lf.enable = true;
    mpd.enable = true;
    syncthing.enable = true;
    yt-dlp.enable = true;
    shell.fish.enable = true;
  };

  # Me
  home.username = "${meta.user}";
  home.homeDirectory = "/home/${meta.user}";
  # Don't change
  home.stateVersion = "24.11"; # Please read the comment before changing.
  # Standalone Packages for user
  home.packages = with pkgs; [
    imagemagick
    ffmpeg
    gst_all_1.gst-libav
    libqalculate
    lshw
    nuspell
    python3
    qbittorrent
    typst
    custom.Subtitlenator

  ];

  # Environment and Dependencies
  xdg.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
