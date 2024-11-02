{ inputs, pkgs, ... }:
{
  imports = [ ./../../homeModules ];

  customhm = {
    helix.enable = true;
    nixvim.enable = false;
    shell.enable = false;
  };
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    neovim
    ranger
    git
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
}
