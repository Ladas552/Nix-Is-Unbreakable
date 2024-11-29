{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.customhm = {
    kakoune.enable = lib.mkEnableOption "enable kakoune";
  };

  config = lib.mkIf config.customhm.kakoune.enable {
    programs.kakoune = {
      enable = true;
      config = {
        colorScheme = "catppuccin_macchiato";
        ui = {
          setTitle = true;
          enableMouse = true;
          assistant = "cat";
        };
      };
      plugins = with pkgs.kakounePlugins; [ ];
    };
    home.file.".config/kak/colors/catppuccin_macchiato.kak" = {
      source = ./catppuccin_macchiato.kak;
    };
  };
}
