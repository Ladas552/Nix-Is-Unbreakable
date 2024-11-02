{ inputs, pkgs, ... }:
{

  imports = [ ./../../homeModules ];

  customhm = {
    helix.enable = true;
  };

  home.username = "ladas552";
  home.homeDirectory = "/home/ladas552";

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
