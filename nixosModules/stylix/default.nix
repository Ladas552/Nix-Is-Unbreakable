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

  imports = [
    inputs.stylix.nixosModules.stylix
    ./oksolar.nix
    ./catppuccin.nix
  ];

  config = lib.mkIf config.custom.stylix.enable {
    #To always use the stylix theme in gtk4 apps
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
      autoEnable = true;

      fonts = {
        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono NFM SemiBold";
        };
        sizes = {
          terminal = if meta.host == "NixPort" then 11 else 13;
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
