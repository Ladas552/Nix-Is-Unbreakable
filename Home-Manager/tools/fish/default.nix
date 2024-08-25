{ config, pkgs, inputs, ... }:

{
  programs.fish = {
    enable = true;
    plugins = with pkgs.fishPlugins; [
      {name = "autopair"; src = autopair.src;}
      {name = "bass"; src = bass.src; }
      {name = "done"; src = done.src; }
      {name = "pisces"; src = pisces.src; }
      {name = "pure"; src = pure.src; }
      {name = "sponge"; src = sponge.src; }
    ];
    shellAbbrs = {
      clean = "nh clean all";
      yy = "nh os switch -u ~/Nix-dots/NixOS/";
      yyh = "nh home switch -u ~/Nix-dots/Home-Manager/";
      en = "nvim ~/Nix-dots/NixOS/";
      eh = "nvim ~/Nix-dots/Home-Manager/home.nix";
      v = "nvim";
      dl-video = "yt-dlp --embed-thumbnail -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4 --output '%(title)s.%(ext)s'";
      dl-clips = "yt-dlp --embed-thumbnail -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4 --ignore-errors --output '/home/ladas552/Videos/clips/%(playlist)s/%(playlist_index)s-%(title)s.%(ext)s' --yes-playlist";
      dl-vocaloid = "yt-dlp --add-metadata --parse-metadata 'playlist_title:%(album)s' --embed-thumbnail --ignore-errors --format bestaudio --extract-audio --audio-format mp3 --output '/home/ladas552/Music/vocaloid/%(playlist_uploader)s/%(playlist)s/%(title)s.%(ext)s' --yes-playlist";
      mc = "ranger";
      mcm = "ranger ~/Music/";
      mcc = "ranger ~/.config/";
      mcp = "ranger ~/Pictures/";
    };
    shellAliases = {
      cat = ''${pkgs.bat}/bin/bat'';
      wiki = ''${pkgs.wiki-tui}/bin/wiki-tui'';
      df = ''${pkgs.duf}/bin/duf'';
      copypaste = ''${pkgs.wgetpaste}/bin/wgetpaste'';
      cmatrix = ''${pkgs.unimatrix}/bin/unimatrix -f -s 95'';
      ls = ''ls --hyperlink=auto'';
      fastfetch = ''${pkgs.fastfetch}/bin/fastfetch | ${pkgs.lolcat}/bin/lolcat '';
    };
  };
}
