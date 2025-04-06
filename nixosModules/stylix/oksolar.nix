{
  lib,
  config,
  meta,
  pkgs,
  ...
}:
{
  options.custom = {
    stylix.oksolar-light = lib.mkEnableOption "enable oksolar-light colorscheme";
  };

  config = lib.mkIf (config.custom.stylix.enable && config.custom.stylix.oksolar-light) {

    stylix = {
      base16Scheme = {
        base00 = "#f1e9d2";
        base01 = "#fbf7ef";
        base02 = "#093946";
        base03 = "#002d38";
        base04 = "#5b6078";
        base05 = "#657377";
        base06 = "#98a8a8";
        base07 = "#8faaab";
        base08 = "#f23749";
        base09 = "#d56500";
        base0A = "#ac8300";
        base0B = "#819500";
        base0C = "#259d94";
        base0D = "#2b90d8";
        base0E = "#7d80d1";
        base0F = "#dd459d";
      };

      polarity = "light";
    };
    home-manager.users."${meta.user}".stylix = {
      targets = {
        bspwm.enable = false;
        # xfce.enable = config.custom.xfce.enable;
        vesktop.enable = true;
        fish.enable = false;
        # nixvim.enable = false;
        # helix.enable = false;
        # emacs.enable = false;
        # ghostty.enable = false;
        rofi.enable = false;
      };
      iconTheme = {
        enable = true;
        package = pkgs.candy-icons;
        dark = "candy-icons";
        light = "candy-icons";
      };
    };
  };
}
