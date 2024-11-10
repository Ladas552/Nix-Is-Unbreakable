{ pkgs, lib, ... }:
{
  imports = [ ./../../homeModules ];

  customhm = {
    helix.enable = true;
    nixvim = {
      enable = true;
      plugins.NixToks = false;
      plugins.NixMux = true;
      keymaps = false;
    };
    shell.enable = false;
    fastfetch.enable = true;
    lf.enable = true;
  };
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    ffmpeg
    libqalculate
    manix
    typst
    ripgrep
    fd
    gcc
    gnumake
    sops
    openssh
    procps
    killall
    diffutils
    findutils
    utillinux
    tzdata
    hostname
    man
    gnugrep
    gnupg
    gnused
    gnutar
    bzip2
    gzip
    xz
    zip
    unzip
  ];

  xdg = {
    enable = true;
  };
  #Shell
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs = {
    ripgrep.enable = true;
    fd.enable = true;
    bat.enable = true;
    fzf = {
      enable = true;
    };
    zoxide = {
      enable = true;
    };
    eza = {
      enable = true;
      extraOptions = [ "--icons" ];
    };
  };
  home.shellAliases = {
    # cli tools
    ls = "eza";
    cd = "z";
    mc = "ranger";
    h = "hx";
    # System Mantaining
    en = "hx ~/Nix-Is-Unbreakable/";
    eh = "hx ~/Nix-Is-Unbreakable/";
    clean = "nix-collect-garbage";
    yy = "nix-on-droid switch -F ~/Nix-Is-Unbreakable#NixMux";
    # Git
    g = "git";
    gal = "git add ./*";
    gcm = "git commit -m";
    gpu = "git push";
    # Neorg
    v = "nvim";
    j = ''nvim -c "Neorg journal today"'';
  };

  #home.file."bin/termux-file-editor".text = "hx";
  #home.file.".termux/termux.properties".source = ./termux.nix;

  home.sessionVariables = lib.mkForce {
    EDITOR = "hx";
    VISUAL = "hx";
    SUDO_EDITOR = "hx";
  };
}
