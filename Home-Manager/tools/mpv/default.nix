{ config, pkgs, inputs, ... }:
{
  programs.mpv = {
    enable = true;
    config = {
      profile = "gpu-hq";
      save-position-on-quit= "true";
      cursor-autohide= 100;
      ytdl-raw-options = "yes-playlist=";
      audio-file-auto= "fuzzy";
      audio-file-paths= "**";
      sub-file-paths= "**";
      sub-auto= "fuzzy";
      slang= "rus,russian,ru,eng,en,english";
      alang= "ja,jpn,japanese,jp,eng,en,english";

      demuxer-mkv-subtitle-preroll = true;
      sub-scale-by-window = true;
    };
    profiles = {
      "extension.webm" = {
        loop-file= "inf";
      };
      "extension.gif" = {
        loop-file= "inf";
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
    scripts = 
      (with pkgs.mpvScripts; [
      sponsorblock-minimal
      reload
      quality-menu
      memo
      autoload
    ]);
  };
}
