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

      fonts = {
        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono NFM";
        };
        sizes = {
          terminal = 14;
          popups = 14;
        };
      };
      cursor = {
        name = "BreezeX-RosePine-Linux";
        size = 28;
        package = pkgs.rose-pine-cursor;
      };
    };
  };
}
