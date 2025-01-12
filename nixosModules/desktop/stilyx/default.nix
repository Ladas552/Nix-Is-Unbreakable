{
  config,
  pkgs,
  lib,
  inputs,
  meta,
  ...
}:

{
  options.custom = {
    stylix.enable = lib.mkEnableOption "enable stylix";
  };

  imports = [ inputs.stylix.nixosModules.stylix ];

  config = lib.mkIf config.custom.stylix.enable {
    home-manager = {
      users."${meta.user}" = import ./home.nix;
    };
    #To always use the dark theme
    environment = {
      etc = {
        "xdg/gtk-3.0/settings.ini".text =
          config.home-manager.users."${meta.user}".xdg.configFile."gtk-3.0/settings.ini".text;
        "xdg/gtk-4.0/settings.ini".text =
          config.home-manager.users."${meta.user}".xdg.configFile."gtk-4.0/settings.ini".text;
      };
    };

    stylix = {
      enable = true;
      image = ./wallpapers/Sacrifice.jpg;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      autoEnable = true;
      polarity = "dark";

      # cursor = {
      #   package = pkgs.catppuccin-cursors;
      #   name = "Catppuccin";
      #   size = 12;
      # };
      fonts = {
        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
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
  };
}
