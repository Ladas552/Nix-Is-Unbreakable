{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.customhm = {
    fish.enable = lib.mkEnableOption "enable fish";
  };

  config = lib.mkIf config.customhm.fish.enable {
    programs.fish = {
      enable = true;
      plugins = with pkgs.fishPlugins; [
        {
          name = "autopair";
          src = autopair.src;
        }
        {
          name = "bass";
          src = bass.src;
        }
        {
          name = "done";
          src = done.src;
        }
        {
          name = "pure";
          src = pure.src;
        }
        {
          name = "puffer";
          src = puffer.src;
        }
        {
          name = "sponge";
          src = sponge.src;
        }
      ];
      shellAbbrs = {
        clean = "nh clean all";
        yy = "nh os switch ~/Nix-dots/";
        yyy = "nh os switch -u ~/Nix-dots/";
        en = "nvim ~/Nix-dots/";
        enn = "nvim ~/Nix-dots/hosts/NixToks/";
        eh = "nvim ~/Nix-dots/homeModules/programs/";
        v = "nvim";
        ls = "eza";
        dl-video = "yt-dlp --embed-thumbnail -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4 --output '%(title)s.%(ext)s'";
        dl-clips = "yt-dlp --embed-thumbnail -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4 --ignore-errors --output '/home/ladas552/Videos/clips/%(playlist)s/%(playlist_index)s-%(title)s.%(ext)s' --yes-playlist";
        dl-vocaloid = "yt-dlp --add-metadata --parse-metadata 'playlist_title:%(album)s' --embed-thumbnail --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --output '/home/ladas552/Music/vocaloid/%(playlist_uploader)s/%(playlist)s/%(title)s.%(ext)s' --yes-playlist";
        mc = "ranger";
        mcv = "ranger ~/Videos/";
        mcva = "ranger ~/Videos/Anime/";
        mcm = "ranger ~/Music/";
        mcc = "ranger ~/.config/";
        mcp = "ranger ~/Pictures/";
      };
      shellAliases = {
        cat = "${lib.getExe pkgs.bat}";
        wiki = "${lib.getExe pkgs.wiki-tui}";
        df = "${lib.getExe pkgs.duf}";
        copypaste = "${lib.getExe pkgs.wgetpaste}";
        cmatrix = "${lib.getExe pkgs.unimatrix} -f -s 95";
        fastfetch = "fastfetch | ${lib.getExe pkgs.lolcat}";
      };
    };
  };
}
