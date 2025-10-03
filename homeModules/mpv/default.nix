{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.customhm = {
    mpv.enable = lib.mkEnableOption "enable mpv";
  };

  config = lib.mkIf config.customhm.mpv.enable {
    home.packages = with pkgs; [
      ff2mpv
    ];
    programs.mpv = {
      enable = true;
      config = {
        profile = "gpu-hq";
        cursor-autohide = 100;
        ytdl-raw-options = "yes-playlist=";
        audio-file-auto = "fuzzy";
        audio-file-paths = "**";
        sub-file-paths = "**";
        sub-auto = "fuzzy";
        slang = "rus,russian,ru,eng,en,english";
        alang = "ja,jpn,japanese,jp,eng,en,english";

        demuxer-mkv-subtitle-preroll = true;
        sub-scale-by-window = true;
      };
      profiles = {
        "extension.webm" = {
          loop-file = "inf";
        };
        "extension.gif" = {
          loop-file = "inf";
        };
        "extension.mp3" = {
          save-position-on-quit = "no";
        };
      };
      bindings = {
        "[" = "add speed -0.25";
        "]" = "add speed 0.25";
        "C" = "cycle sub";
        "A" = "cycle audio";
        "V" = "cycle video";
        "<" = "add chapter -1";
        ">" = "add chapter 1";
        "K" = "add sub-scale +0.1";
        "J" = "add sub-scale -0.1";
      };
      scripts = (
        with pkgs.mpvScripts;
        [
          sponsorblock-minimal
          reload
          mpris
          quality-menu
          memo
          autoload
        ]
      );
      extraInput = ''
        Ctrl+f script-binding quality_menu/video_formats_toggle #! Stream Quality > Video
      '';
      scriptOpts = {
        quality-menu = {
          quality_strings_video = ''[ {"1080p" : "bestvideo[height<=?1080]"}, {"720p" : "bestvideo[height<=?720]"}, {"480p" : "bestvideo[height<=?480]"}, {"360p" : "bestvideo[height<=?360]"}, {"240p" : "bestvideo[height<=?240]"}, {"144p" : "bestvideo[height<=?144]"} ]'';
          columns_video = ''-resolution|bitrate_total,size,codec_video'';
          fetch_formats = "no";
          hide_identical_columns = "yes";
        };
      };
    };

    # persist for Impermanence
    customhm.imp.home.cache.directories = [ ".local/state/mpv/watch_later" ];
  };
}
