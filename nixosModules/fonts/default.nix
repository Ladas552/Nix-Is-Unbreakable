{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom = {
    fonts.enable = lib.mkEnableOption "enable fonts";
  };

  config = lib.mkIf config.custom.fonts.enable {
    # stolen from saygo
    fonts = {
      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = config.fonts.fontconfig.defaultFonts.monospace;
          sansSerif = config.fonts.fontconfig.defaultFonts.monospace;
          monospace = [ "JetBrainsMono Nerd Font Mono" ];
        };
        antialias = true;
        hinting = {
          enable = true;
          style = "full";
          autohint = false;
        };
        subpixel = {
          rgba = "none";
          lcdfilter = "default";
        };
      };
    };
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.jetbrains-mono
      # Enable nerd fonts for every font
      #(lib.filter lib.isDerivation (lib.attrValues pkgs.nerd-fonts))
    ];
  };
}
