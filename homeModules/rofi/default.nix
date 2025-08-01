{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

{
  options.customhm = {
    rofi.enable = lib.mkEnableOption "enable rofi";
  };

  config = lib.mkIf config.customhm.rofi.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      font = "JetBrains Mono Nerd Font 11";
      # terminal = "${lib.getExe inputs.ghostty.packages.x86_64-linux.default}";
      # terminal = "${lib.getExe' pkgs.ghostty "ghostty"}";
      terminal = "footclient";
      theme = ./theme.rasi;
    };
  };
}
