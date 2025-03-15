{ lib, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
  stylix.targets = {
    bspwm.enable = false;
    kitty.enable = false;
    # xfce.enable = config.custom.xfce.enable;
    vesktop.enable = true;
    fish.enable = false;
    nixvim.enable = false;
    helix.enable = false;
    emacs.enable = false;
    ghostty.enable = false;
    rofi.enable = false;
  };
  # Icons
  stylix.iconTheme = {
    enable = true;
    package = pkgs.candy-icons;
    dark = "candy-icons";
    light = "candy-icons";
  };
}
