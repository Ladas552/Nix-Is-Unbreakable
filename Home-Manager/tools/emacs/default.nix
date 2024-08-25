{ config, pkgs, inputs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-git-nox;
    extraPackages = epkgs: with pkgs.emacsPackages; [
      org
      zk
    ];
  };
  services.emacs.enable = true;
}
