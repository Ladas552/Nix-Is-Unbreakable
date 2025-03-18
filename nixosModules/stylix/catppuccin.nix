{
  lib,
  config,
  meta,
  pkgs,
  ...
}:
{
  options.custom = {
    stylix.catppuccin = lib.mkEnableOption "enable catppuccin colorscheme";
  };

  config = lib.mkIf (config.custom.stylix.enable && config.custom.stylix.catppuccin) {
    stylix = {
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    };
    home-manager.users."${meta.user}" = {
      stylix = {
        targets = {
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
        iconTheme = {
          enable = true;
          package = pkgs.candy-icons;
          dark = "candy-icons";
          light = "candy-icons";
        };
      };
      # dconf.settings = lib.mkForce {
      #   "org/gnome/desktop/interface" = {
      #     color-scheme = "prefer-dark";
      #   };
      # };
    };
  };
}
