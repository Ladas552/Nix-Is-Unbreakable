{ lib, config, ... }:
{

  options.customhm = {
    yt-dlp.enable = lib.mkEnableOption "enable yt-dlp";
  };
  config = lib.mkIf config.customhm.yt-dlp.enable {
    programs.yt-dlp = {
      enable = true;
    };
    home.shellAliases = {
      dl-video = "yt-dlp --embed-thumbnail -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4 --output '%(title)s.%(ext)s'";
      dl-clips = "yt-dlp --embed-thumbnail -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4 --ignore-errors --output '${config.xdg.userDirs.videos}/clips/%(playlist)s/%(playlist_index)s-%(title)s.%(ext)s' --yes-playlist";
      dl-vocaloid = "yt-dlp --add-metadata --parse-metadata 'playlist_title:%(album)s' --embed-thumbnail --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output '${config.xdg.userDirs.music}/vocaloid/%(playlist_uploader)s/%(playlist)s/%(title)s.%(ext)s' --download-archive '${config.xdg.userDirs.music}/vocaloid/archive-file' --yes-playlist --max-filesize '20.0M'";
      dl-vocaloid-batch = "yt-dlp --add-metadata --parse-metadata 'playlist_title:%(album)s' --embed-thumbnail --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --audio-quality 0 --output '${config.xdg.userDirs.music}/vocaloid/%(playlist_uploader)s/%(playlist)s/%(title)s.%(ext)s' --download-archive '${config.xdg.userDirs.music}/vocaloid/archive-file' --yes-playlist --max-filesize '20.0M' --batch-file '${config.xdg.userDirs.music}/vocaloid/batch-file'";
    };
  };
}
