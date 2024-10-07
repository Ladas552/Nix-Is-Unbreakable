{
  pkgs,
  lib,
  config,
  ...
}:

{

  options.customhm = {
    chromium.enable = lib.mkEnableOption "enable chromium";
  };
  config = lib.mkIf config.customhm.chromium.enable {
    programs.chromium = {
      enable = true;
      commandLineArgs = [ "--no-default-browser-check" ];
      package = pkgs.ungoogled-chromium;
      dictionaries = [ pkgs.hunspellDictsChromium.en_US ];
    };
  };
}
