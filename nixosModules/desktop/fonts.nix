{ config, lib, pkgs, ...}:

{
  options.custom = {
    fonts.enable = lib.mkEnableOption "enable fonts";
  };

  config = lib.mkIf config.custom.fonts.enable {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      jetbrains-mono
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
  };
}