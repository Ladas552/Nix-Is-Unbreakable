{ lib, config, ... }:

{

  options.customhm = {
    ghostty.enable = lib.mkEnableOption "enable ghostty";
  };
  config = lib.mkIf config.customhm.ghostty.enable {
    home.file.".config/ghostty/config" = {
      source = ./config;
    };

    home.sessionVariables = {
      TERMINAL = "xterm-ghostty";
      TERM = "xterm-ghostty";
    };
  };
}
