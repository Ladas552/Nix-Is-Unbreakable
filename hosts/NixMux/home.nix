{  pkgs, ... }:
{
  imports = [ ./../../homeModules ];

  customhm = {
    helix.enable = true;
    nixvim.enable = false;
    shell.enable = false;
    git.enable = true;
    ranger.enable = true;
  };
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
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

};    home.shellAliases = {
      ls = "eza";
      cd = "z";
      mc = "ranger";
      clean = "nix-collect-garbage";
      yy = "nix-on-droid switch -F ~/Nix-Is-Unbreakable#NixMux";
    };
}
