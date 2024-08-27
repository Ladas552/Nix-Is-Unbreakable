{ config, lib, pkgs, ...}:

{
  options = {
    fonts.enable = lib.mkEnableOption "enable fonts";
  };

  config = lib.mkIf config.fonts.enable {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };
}
