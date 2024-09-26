{ lib, config, ... }:

{
  options.customhm = {
    fastfetch.enable = lib.mkEnableOption "enable fastfetch";
  };

  config = lib.mkIf config.customhm.fastfetch.enable {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo.source = "nixos_small";
        display = {
          size = {
            binaryPrefix = "si";
          };
          separator = "  ";
        };
        modules = [
          "de"
          "wm"
          "terminal"
          "shell"
          "editor"
          "cpu"
        ];
      };
    };
  };
}
