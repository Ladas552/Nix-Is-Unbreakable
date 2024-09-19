{ pkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  imports = [
    ./../../homeModules
  ];

  customhm = {
    #   chromium.enable = true;
    flameshot.enable = true;
    imv.enable = true;
    kitty.enable = true;
    mangohud.enable = true;
    mpd.enable = true;
    mpv.enable = true;
    obs.enable = true;
    syncthing.enable = true;
    yt-dlp.enable = true;
    zathura.enable = true;
  };
  # Me
  home.username = "ladas552";
  home.homeDirectory = "/home/ladas552";
  # Don't change
  home.stateVersion = "23.11"; # Please read the comment before changing.
  # Standalone Packages for user
  home.packages = with pkgs; [
    #pkgs-stable.
       inputs.ghostty.packages.x86_64-linux.default
    blender
    candy-icons
    catppuccin-cursors
    cowsay
    ffmpeg
    floorp
    hello
    hunspell
    hunspellDicts.en-us-large
    hunspellDicts.ru-ru
    keepassxc
    libqalculate
    libreoffice-fresh
    losslesscut-bin
    lshw
    manix
    numlockx
    nuspell
    pamixer
    pavucontrol
    peek
    python3
    qbittorrent
    rofi-wayland
    telegram-desktop
    #   texlive.combined.scheme-small
    texliveFull
    typst
    vesktop
    xarchiver
    xclip
  ];

  nixpkgs.config.allowUnfree = true;
  #  home.file = {
  #
  # # You can also set the file content immediately.
  #".gradle/gradle.properties".text = ''
  #   org.gradle.console=verbose
  #   org.gradle.daemon.idletimeout=3600000
  # '';
  #
  #  };
  # Environment and Dependencies
  xdg = {
    enable = true;
    #    mime.enable = true;
    #    mimeApps = {
    #      enable = true;
    #      associations.added = {
    #        "text/plain" = ["neovim.desktop"];
    #        "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];
    #        "image/*" = ["imv.desktop"];
    #        "video/*" = ["mpv.desktop"];
    #      };
    #      defaultApplications = {
    #        "text/plain" = [""];
    #        "application/pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];
    #        "image/*" = ["imv.desktop"];
    #        "video/*" = ["mpv.desktop"];
    #      };
    #    };
  };

  # Environmental Variables
  home.sessionVariables = {
    BROWSER = "floorp"; 
    #XDG_BIN_HOME = "$HOME/.local/bin";
    #PATH = "$HOME/.local/bin";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  #programs.home-manager.path = "$HOME/Nix-dots/Home-Manager";
}
