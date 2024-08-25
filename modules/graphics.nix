{ config, pkgs, lib, inputs, stylix, ... }:
{
  #Themes
  stylix = {
    enable = true;
    image = ./wallpapers/Bones.png;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    autoEnable = true;
    polarity = "dark";
    # targets = {
    #   bspwm.enable = false;
    #   nixvim.enable = false;
    #   kitty.enable = false;
    #   fish.enable = false;
    #   xfce.enable = true;
    #   vesktop.enable = true;
    #   gtk.enable = true;
    # };
    fonts = {
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      monospace = {
        package = pkgs.jetbrains-mono;
        name = "JetBrainsMono";
      };
      sizes = {
        terminal = 14;
        popups = 14;
      };
    };
  };
  #  gtk = {
  #    enable = true;
  #    theme = {
  #      name = "Graphite-dark";
  #      package = pkgs.graphite-gtk-theme;
  #    };
  #    iconTheme = {
  #      name = "Candy";
  #      package = pkgs.candy-icons;
  #    };
  #    cursorTheme = {
  #      name = "Graphite";
  #      package = pkgs.graphite-cursors;
  #    };
  #    gtk3.extraConfig = {
  #      Settings = ''
  #        gtk-application-prefer-dark-theme=1
  #        '';
  #    };
  #    gtk4.extraConfig = {
  #      Settings = ''
  #        gtk-application-prefer-dark-theme=1
  #        '';
  #    };
  #  };
  #  qt = {
  #    enable = true;
  #    platformTheme = "gtk";
  #    style.name = "adwaita-dark";
  #  };
  #  programs.gpg.enable = true;
  #
  #  services.gpg-agent.enable = true;
}
