{ lib, config, ... }:

{

  options.customhm = {
    yt-dlp.enable = lib.mkEnableOption "enable yt-dlp";
  };
  config = lib.mkIf config.customhm.yt-dlp.enable {
    programs.yt-dlp = {
      enable = true;
    };
  };
}
