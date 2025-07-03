{
  pkgs,
  inputs,
  meta,
  lib,
  ...
}:

{
  imports = [ ./../../homeModules ];

  customhm = {
    vim.enable = true;
    chromium.enable = true;
    nixvim.enable = true;
    direnv.enable = true;
    fastfetch.enable = true;
    gh.enable = true;
    ghostty.enable = true;
    helix.enable = true;
    imv.enable = true;
    lf.enable = true;
    mpv.enable = true;
    obs.enable = true;
    vesktop.enable = true;
    rofi.enable = true;
    thunderbird.enable = true;
    zathura.enable = true;
    shell.fish.enable = true;
  };

  # Me
  home.username = "${meta.user}";
  home.homeDirectory = "/home/${meta.user}";
  # Don't change
  home.stateVersion = "25.05"; # Please read the comment before changing.
  # Standalone Packages for user
  home.packages = with pkgs; [
    libreoffice-fresh
    # shotcut
    imagemagick
    wl-clipboard
    ffmpeg
    gst_all_1.gst-libav
    libqalculate
    lshw
    pamixer
    pwvucontrol
    qbittorrent
    telegram-desktop
    xarchiver
  ];

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
    BROWSER = "chromium";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # wget install script

  home.shellAliases = {
    wget-install = "${lib.getExe' pkgs.wget "wget"} https://raw.githubusercontent.com/Ladas552/Nix-Is-Unbreakable/refs/heads/master/docs/zfs.norg";
    git-install = "${lib.getExe' pkgs.git "git"} clone https://github.com/Ladas552/Nix-Is-Unbreakable.git";
  };
}
