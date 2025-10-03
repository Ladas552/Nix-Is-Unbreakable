{ lib, config, ... }:

{

  options.customhm = {
    qutebrowser.enable = lib.mkEnableOption "enable qutebrowser";
  };
  config = lib.mkIf config.customhm.qutebrowser.enable {
    programs.qutebrowser = {
      enable = true;
    };

    # persist for Impermanence
    customhm.imp.home.cache.files = [
      ".config/qutebrowser/quickmarks"
      ".config/qutebrowser/bookmarks/urls"
    ];
  };
}
