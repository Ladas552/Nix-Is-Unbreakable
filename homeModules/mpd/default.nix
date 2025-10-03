{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.customhm = {
    mpd.enable = lib.mkEnableOption "enable mpd";
  };

  config = lib.mkIf config.customhm.mpd.enable {
    home.packages = with pkgs; [
      mpc-cli
      custom.musnow
    ];
    programs.ncmpcpp = {
      enable = false;
      bindings = [
        {
          key = "n";
          command = "next";
        }
        {
          key = "b";
          command = "previous";
        }
        {
          key = "Q";
          command = "quit";
        }
        {
          key = "*";
          command = "next_found_item";
        }
        {
          key = "-";
          command = "previous_found_item";
        }
        {
          key = "C";
          command = "toggle_consume";
        }
        {
          key = "r";
          command = "toggle_random";
        }
        {
          key = "R";
          command = "toggle_repeat";
        }
        {
          key = ",";
          command = "seek_backward";
        }
        {
          key = ".";
          command = "seek_forward";
        }
        {
          key = "2";
          command = "show_search_engine";
        }
        {
          key = "2";
          command = "reset_search_engine";
        }
        {
          key = "3";
          command = "show_media_library";
        }
        {
          key = "3";
          command = "toggle_media_library_columns_mode";
        }
        {
          key = "4";
          command = "show_playlist_editor";
        }
        {
          key = "5";
          command = "show_tag_editor";
        }
        {
          key = "6";
          command = "show_outputs";
        }
        {
          key = "7";
          command = "change_browse_mode";
        }
        {
          key = "7";
          command = "show_browser";
        }
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

    # settings for rmpc, half Home-manager module, but poorly done
    # Todo. add keybinds for skiping to next album with `[` & `]` when it's added to rmpc
    programs.rmpc = {
      enable = true;
      config = # ron
        ''
          #![enable(implicit_some)]
          #![enable(unwrap_newtypes)]
          #![enable(unwrap_variant_newtypes)]
          (
              address: "127.0.0.1:6600",
              theme: Some("bash"),
              cache_dir: "~/.cache/rmpc/",
              on_song_change: None,
              volume_step: 2,
              scrolloff: 2,
              enable_mouse: true,
              wrap_navigation: true,
              status_update_interval_ms: 1000,
              select_current_song_on_change: true,
              album_art: (
                  method: ${if (config.customhm.ghostty.enable == true) then "Kitty" else "Sixel"},
              ),
              keybinds: (
                  global: {
                      "1":       QueueTab,
                      "2":       DirectoriesTab,
                      "3":       ArtistsTab,
                      "4":       AlbumsTab,
                      "5":       PlaylistsTab,
                      "6":       SearchTab,
                      "7":       ShowOutputs,
                      "?":       ShowHelp,
                      ":":       CommandMode,
                      "Q":       Stop,
                      "c":       ToggleSingle,
                      "<Tab>":   NextTab,
                      "<S-Tab>": PreviousTab,
                      "q":       Quit,
                      "n":       NextTrack,
                      "N":       PreviousTrack,
                      "b":       PreviousTrack,
                      ".":       SeekForward,
                      ",":       SeekBack,
                      "k":       VolumeDown,
                      "l":       VolumeUp,
                      "r":       ToggleRandom,
                      "C":       ToggleConsume,
                      "p":       TogglePause,
                      "R":       ToggleRepeat,
                  },
                  navigation: {
                      "<C-u>":   UpHalf,
                      "=":       NextResult,
                      "-":       PreviousResult,
                      "<Space>":       Add,
                      "A":       AddAll,
                      "g":       Top,
                      "G":       Bottom,
                      "<CR>":    Confirm,
                      "i":       FocusInput,
                      "J":       MoveDown,
                      "<Up>":       Up,
                      "<Down>":       Down,
                      "<Left>":       Left,
                      "<Right>":       Right,
                      "<C-d>":   DownHalf,
                      "/":       EnterSearch,
                      "<C-c>":   Close,
                      "<Esc>":   Close,
                      "K":       MoveUp,
                      "D":       Delete,
                  },
                  queue: {
                      "D":       DeleteAll,
                      "<CR>":    Play,
                      "<C-s>":   Save,
                      "a":       AddToPlaylist,
                      "d":       Delete,
                  },
              ),
          )
        '';
    };

    home.file.".config/rmpc/themes/bash.ron" = {
      recursive = true;
      text = # ron
        ''
          #![enable(implicit_some)]
          #![enable(unwrap_newtypes)]
          #![enable(unwrap_variant_newtypes)]
          (
              album_art_position: Right,
              album_art_width_percent: 40,
              default_album_art_path: None,
              show_song_table_header: true,
              draw_borders: true,
              browser_column_widths: [10, 38, 42],
              background_color: None,
              text_color: None,
              header_background_color: None,
              modal_background_color: None,
              tab_bar: (
                  enabled: false,
                  active_style: (fg: "black", bg: "blue", modifiers: "Bold"),
                  inactive_style: (),
              ),
              highlighted_item_style: (fg: "blue", modifiers: "Bold"),
              current_item_style: (fg: "black", bg: "blue", modifiers: "Bold"),
              borders_style: (fg: "blue"),
              highlight_border_style: (fg: "blue"),
              symbols: (song: "", dir: "", marker: "M"),
              progress_bar: (
                  symbols: ["-", "C", "•"],
                  track_style: (fg: "white"),
                  elapsed_style: (fg: "green"),
                  thumb_style: (fg: "green", bg: "#1e2030"),
              ),
              scrollbar: (
                  symbols: ["│", "█", "▲", "▼"],
                  track_style: (),
                  ends_style: (),
                  thumb_style: (fg: "blue"),
              ),
              song_table_format: [
                  (
                      prop: (kind: Property(Title),
                          default: (kind: Text("Unknown"))
                      ),
                      width_percent: 45,
                  ),
                  (
                      prop: (kind: Property(Artist),
                          default: (kind: Text("Unknown"))
                      ),
                      width_percent: 45,
                  ),
                  (
                      prop: (kind: Property(Duration),
                          default: (kind: Text("-"))
                      ),
                      width_percent: 10,
                      alignment: Right,
                  ),
              ],
              header: (
                  rows: [
                      (
                          left: [
                              (kind: Property(Status(Elapsed))),
                              (kind: Text(" / ")),
                              (kind: Property(Status(Duration))),
                          ],
                          center: [
                              (
                                  kind: Property(Widget(States(
                                      active_style: (fg: "white", modifiers: "Bold"),
                                      separator_style: (fg: "white")))
                                  ),
                                  style: (fg: "dark_gray")
                              ),
                          ],
                          right: [
                              (kind: Property(Widget(Volume)), style: (fg: "red"))
                          ]
                      ),
                  ],
              ),
              browser_song_format: [
                  (
                      kind: Group([
                          (kind: Property(Track)),
                          (kind: Text(" ")),
                      ])
                  ),
                  (
                      kind: Group([
                          (kind: Property(Artist)),
                          (kind: Text(" - ")),
                          (kind: Property(Title)),
                      ]),
                      default: (kind: Property(Filename))
                  ),
              ],
          )
        '';
    };
    # Enable if discord is pressent on the system
    services.mpd-discord-rpc = {
      enable = config.services.arrpc.enable;
      settings = {
        format = {
          details = "$title";
          state = "By $artist";
          large_image = ":nerd:";
          large_text = "WW91IGhhdmUgbm8gbGlmZQ==";
          small_text = "WW91IGhhdmUgbm8gbGlmZQ==";
        };
      };
    };
    services.mpdris2 = {
      # enable = true;
      multimediaKeys = true;
      notifications = true;
    };

    services.mpd = {
      enable = true;
      musicDirectory = config.xdg.userDirs.music;
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

    # persist for Impermanence
    customhm.imp.home.cache.directories = [".local/share/mpd"];
  };
}
