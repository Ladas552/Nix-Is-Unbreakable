{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    rmpc
    mpc-cli
  ];
  programs.ncmpcpp = {
    enable = true;
    bindings = [
      { key = "n"; command = "next"; }
      { key = "b"; command = "previous"; }
      { key = "Q"; command = "quit"; }
      { key = "*"; command = "next_found_item"; }
      { key = "-"; command = "previous_found_item"; }
      { key = "C"; command = "toggle_consume"; }
      { key = "r"; command = "toggle_random"; }
      { key = "R"; command = "toggle_repeat"; }
      { key = ","; command = "seek_backward"; }
      { key = "."; command = "seek_forward"; }
      { key = "2"; command = "show_search_engine"; }
      { key = "2"; command = "reset_search_engine"; }
      { key = "3"; command = "show_media_library"; }
      { key = "3"; command = "toggle_media_library_columns_mode"; }
      { key = "4"; command = "show_playlist_editor"; }
      { key = "5"; command = "show_tag_editor"; }
      { key = "6"; command = "show_outputs"; }
      { key = "7"; command = "change_browse_mode"; }
      { key = "7"; command = "show_browser"; }
    ];
    settings = {
      song_status_format = "%a: %t";
      visualizer_fps = 30;
      song_columns_list_format = "(20)[]{a} (50)[white]{t|f:Title} (20)[cyan]{b} (7f)[magenta]{l} (6f)[green]{NE}";
      playlist_display_mode = "columns";
      seek_time = 5;
      autocenter_mode = "yes";
      centered_cursor = "yes";
      progressbar_look = "-C•";
      user_interface = "classic";
      media_library_albums_split_by_date = "no";
      media_library_hide_album_dates = "yes";
      cyclic_scrolling = "yes";
      screen_switcher_mode = "playlist, clock";
      startup_slave_screen = "";
      clock_display_seconds = "yes";
      lines_scrolled = 1;
      volume_color = "red";
      window_border_color = "red";
      active_window_border = "red";
    };
  };

  services.mpd = {
    enable = true;
    musicDirectory = "~/Music/";
    extraConfig = ''
    audio_output {
      type "pipewire"
      name "Pipewire Sounds Server"
    }
    audio_output {  
      type               "fifo"  
      name               "toggle_visualizer"
      path               "/tmp/mpd.fifo"
      format             "44100:16:2"
    }
    auto_update "yes"
    metadata_to_use "artist, album, title, track, name, genre, date, composer, performer, disc, comment"
    '';
  };
}
