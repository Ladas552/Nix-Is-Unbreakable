{ config, pkgs, inputs, ... }:
{
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "macchiato"; # "mocha"; darker
    };
  };
}
