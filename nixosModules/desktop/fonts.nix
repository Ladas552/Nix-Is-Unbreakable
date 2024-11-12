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
        # defaultFonts = {
        #   serif = config.fonts.fontconfig.defaultFonts.monospace;
        #   sansSerif = config.fonts.fontconfig.defaultFonts.monospace;
        #   monospace = ["Pixel Code"];
        # };
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
      jetbrains-mono
      pixel-code
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      #(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };
}
