{
  lib,
  config,
  meta,
  ...
}:

{
  customhm = {
    mako.enable = lib.mkDefault true;
    swaylock.enable = lib.mkDefault true;
    wpaperd.enable = lib.mkDefault true;
  };
  stylix.targets.niri.enable = false;
  programs.niri = {
    settings = {
      #one liners
      hotkey-overlay.skip-at-startup = true;
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/screenshots/Niri%Y-%m-%d %H-%M-%S.png";
      layout.default-column-display = "tabbed";
      cursor.hide-after-inactive-ms = 10000;
      gestures.hot-corners.enable = false;
      # Autostart
      spawn-at-startup = [
        {
          command = [
            "xfce4-power-manager"
            "--daemon"
          ];
        }
        { command = [ "wpaperd" ]; }
        {
          command = [
            "thunar"
            "-d"
          ];
        }
      ];
      # Monitors
      outputs."eDP-1".scale = if meta.host == "NixPort" then 1.5 else 1.0;
      outputs."HDMI-A-1" = {
        # scale = 2.0;
        scale = 1.0;
        mode = {
          height = 1080;
          refresh = 60.000;
          width = 1920;
        };
      };
      # Input Devices
      input = {
        mod-key = "Alt";
        workspace-auto-back-and-forth = true;
        keyboard = {
          xkb.layout = "us,kz";
          xkb.options = "grp:caps_toggle";
        };
        mouse.accel-profile = "flat";
        touchpad = {
          tap = true;
          natural-scroll = true;
          middle-emulation = true;
          scroll-factor = 1.0;
        };
      };
      # Environmental Variables
      environment = {
        TERMINAL = "ghostty";
        DISPLAY = ":0";
        __NV_PRIME_RENDER_OFFLOAD = "1";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      };
      # Looks & UI
      layout = {
        gaps = 4;
        center-focused-column = "never";
        default-column-width.proportion = 0.5;
        border.enable = false;
        focus-ring = {
          width = 4;
          active.gradient = {
            from = "#7700AE";
            to = "#0060FF";
            angle = 45;
          };
        };
        tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          position = "right";
          gaps-between-tabs = 10.0;
          width = 4.0;
          length.total-proportion = 0.1;
          corner-radius = 10.0;
          gap = -8.0;
          active = {
            color = "#BA4B5D";
          };
        };
        preset-column-widths = [
          { proportion = 0.25; }
          { proportion = 0.5; }
          { proportion = 0.75; }
          { proportion = 1.0; }
        ];
      };
      # Window Rules
      window-rules = [
        # Shadows in floating mode
        {
          matches = [
            { is-floating = true; }
          ];
          shadow.enable = true;
        }
        {
          matches = [
            { app-id = "mpv"; }
          ];
          shadow.enable = false;
        }
        {
          matches = [ { title = "Picture-in-Picture"; } ];
          default-column-width.fixed = 420;
          default-window-height.fixed = 236;
          default-floating-position.x = 50;
          default-floating-position.y = 50;
          default-floating-position.relative-to = "bottom-right";
          open-focused = false;
          open-floating = true;
        }
        # Full screen/size apps
        {
          matches = [ { app-id = "steam_proton"; } ];
          default-column-width = { };
        }
        {
          matches = [
            { app-id = ".qemu-system-x86_64-wrapped"; }
            { app-id = "vesktop"; }
            { app-id = "legcord"; }
            { app-id = "steam_app_0"; }
            { app-id = "darksoulsii.exe"; }
            { app-id = "steam-"; }
            { title = "DARK SOULS II"; }
            { app-id = "osu!"; }
            { title = "osu!"; }
          ];
          variable-refresh-rate = false;
          open-fullscreen = true;
          default-column-width.proportion = 1.0;
        }
        {
          matches = [
            { app-id = "librewolf"; }
            { app-id = "thunderbird"; }
          ];
          open-maximized = true;
        }
        # Screencast
        {
          matches = [
            { app-id = ''r#"^org\.keepassxc\.KeePassXC$"#''; }
            { app-id = ''r#"^org\.gnome\.World\.Secrets$"#''; }
          ];
          block-out-from = "screencast";
        }
        {
          matches = [
            { is-window-cast-target = true; }
          ];
          border = {
            enable = true;
            active.color = "#BA4B5D";
            inactive.color = "#BA4B5D";
          };
        }
      ];
      switch-events = {
        lid-close.action.spawn = [
          "niri"
          "msg"
          "action"
          "power-off-monitors"
        ];
        lid-open.action.spawn = [
          "niri"
          "msg"
          "action"
          "power-on-monitors"
        ];
      };
      # Keybinds
      binds = with config.lib.niri.actions; {
        # Apps
        "Super+T".action = spawn "ghostty";
        "Super+Space".action = spawn [
          "rofi"
          "-show"
        ];
        "Super+L".action = spawn "swaylock";
        # "Super+E".action = spawn "emacs";
        "Super+N".action = spawn [
          "ghostty"
          "-e"
          "nvim"
        ];
        "Super+J".action = spawn [
          "ghostty"
          "-e"
          "nvim"
          "-c"
          "'Neorg journal today'"
        ];
        "Super+M".action = spawn [
          "ghostty"
          "-e"
          "rmpc"
        ];
        "Super+H".action = spawn [
          "ghostty"
          "-e"
          "btop"
        ];
        "Super+G".action = spawn [
          "ghostty"
          "-e"
          "qalc"
        ];
        # GUI apps
        "Super+F".action = spawn "thunar";
        "Super+W".action = spawn "librewolf";
        # MPD
        "Shift+Alt+P" = {
          action = spawn [
            "mpc"
            "toggle"
          ];
          allow-when-locked = true;
        };
        "Shift+Alt+N" = {
          action = spawn [
            "mpc"
            "next"
          ];
          allow-when-locked = true;
        };
        "Shift+Alt+B" = {
          action = spawn [
            "mpc"
            "prev"
          ];
          allow-when-locked = true;
        };
        "Shift+Alt+K" = {
          action = spawn [
            "mpc"
            "volume"
            "-5"
          ];
          allow-when-locked = true;
        };
        "Shift+Alt+L" = {
          action = spawn [
            "mpc"
            "volume"
            "+5"
          ];
          allow-when-locked = true;
        };
        "Shift+Alt+C".action = spawn [
          "mpc"
          "clear"
        ];
        "Shift+Alt+M".action = spawn [ "musnow.sh" ];

        # Scripts
        "Super+C".action = spawn [ "word-lookup.sh" ];
        "Super+X".action = spawn [ "powermenu.sh" ];
        #Example volume keys mappings for PipeWire & WirePlumber.
        #The allow-when-locked=true property makes them work even when the session is locked.
        "XF86AudioRaiseVolume" = {
          action = spawn [
            "pamixer"
            "-i"
            "2"
            # "wpctl"
            # "set-volume"
            # "@DEFAULT_AUDIO_SINK@"
            # "0.02+"
          ];
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action = spawn [
            "pamixer"
            "-d"
            "2"
            # "wpctl"
            # "set-volume"
            # "@DEFAULT_AUDIO_SINK@"
            # "0.02-"
          ];
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action = spawn [
            "pamixer"
            "-t"
            # "wpctl"
            # "set-mute"
            # "@DEFAULT_AUDIO_SINK@"
            # "toggle"
          ];
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action = spawn [
            "wpctl"
            "set-mute"
            "@DEFAULT_AUDIO_SOURCE@"
            "toggle"
          ];
          allow-when-locked = true;
        };

        # Brightnes
        "XF86MonBrightnessUp" = {
          action = spawn [
            "brightnessctl"
            "set"
            "10%+"
          ];
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = {
          action = spawn [
            "brightnessctl"
            "set"
            "10%-"
          ];
          allow-when-locked = true;
        };

        # shows a list of important hotkeys.
        "Super+Shift+T".action = show-hotkey-overlay;
        # Screenshots
        # was testing if it got better quility
        # "Print".action = spawn [
        #   "sh"
        #   "-c"
        #   "${lib.getExe pkgs.slurp} | ${lib.getExe pkgs.grim} -g -"
        # ];
        "Print".action = screenshot;
        "Shift+Print".action.screenshot-screen = [ ];
        "Alt+Print".action = screenshot-window;
        # Window Management
        "Super+Q".action = close-window;
        # Floating Windows
        "Ctrl+Alt+S".action = toggle-window-floating;
        "Super+Tab".action = switch-focus-between-floating-and-tiling;
        # Tabbed layout
        "Ctrl+Alt+A".action = toggle-column-tabbed-display;

        "Super+Left".action = focus-column-left-or-last;
        "Super+Down".action = focus-window-down-or-top;
        "Super+Up".action = focus-window-up-or-bottom;
        "Super+Right".action = focus-column-right-or-first;
        "Super+A".action = focus-column-left-or-last;
        "Super+S".action = focus-column-right-or-first;

        "Super+Shift+Left".action = move-column-left;
        "Super+Shift+Down".action = move-window-down;
        "Super+Shift+Up".action = move-window-up;
        "Super+Shift+Right".action = move-column-right;
        "Super+Shift+A".action = move-column-left;
        "Super+Shift+S".action = move-column-right;
        # "Super+Ctrl+H".action = move-column-left;
        # "Super+Ctrl+J".action = move-window-down;
        # "Super+Ctrl+K".action = move-window-up;
        # "Super+Ctrl+L".action = move-column-right;

        "Super+Page_Up".action = focus-column-first;
        "Super+Page_Down".action = focus-column-last;
        "Super+Shift+Page_Up".action = move-column-to-first;
        "Super+Shift+Page_Down".action = move-column-to-last;

        "Super+Ctrl+Right".action = focus-monitor-right;
        "Super+Ctrl+Down".action = focus-monitor-down;
        "Super+Ctrl+Up".action = focus-monitor-up;
        "Super+Ctrl+Left".action = focus-monitor-left;

        "Super+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "Super+Shift+Ctrl+Down".action = move-column-to-monitor-down;
        "Super+Shift+Ctrl+Up".action = move-column-to-monitor-up;
        "Super+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "Super+Shift+H".action = move-column-to-monitor-left;
        "Super+Shift+J".action = move-column-to-monitor-down;
        "Super+Shift+K".action = move-column-to-monitor-up;
        "Super+Shift+L".action = move-column-to-monitor-right;

        "Super+Ctrl+A".action = focus-workspace-up;
        "Super+Ctrl+S".action = focus-workspace-down;

        "Super+Shift+Ctrl+A".action = move-column-to-workspace-up;
        "Super+Shift+Ctrl+S".action = move-column-to-workspace-down;
        # Mouse scroll
        "Super+WheelScrollDown" = {
          action = focus-workspace-down;
          cooldown-ms = 150;
        };
        "Super+WheelScrollUp" = {
          action = focus-workspace-up;
          cooldown-ms = 150;
        };
        "Super+Ctrl+WheelScrollDown" = {
          action = move-column-to-workspace-down;
          cooldown-ms = 150;
        };
        "Super+Ctrl+WheelScrollUp" = {
          action = move-column-to-workspace-up;
          cooldown-ms = 150;
        };

        "Super+WheelScrollRight".action = focus-column-right;
        "Super+WheelScrollLeft".action = focus-column-left;
        "Super+Ctrl+WheelScrollRight".action = move-column-right;
        "Super+Ctrl+WheelScrollLeft".action = move-column-left;

        "Super+Shift+WheelScrollDown".action = focus-column-right;
        "Super+Shift+WheelScrollUp".action = focus-column-left;
        "Super+Ctrl+Shift+WheelScrollDown".action = move-column-right;
        "Super+Ctrl+Shift+WheelScrollUp".action = move-column-left;

        # Touchpad gestures
        ## Workspaces
        "Super+Shift+TouchpadScrollUp".action = move-column-to-workspace-up;
        "Super+Shift+TouchpadScrollDown".action = move-column-to-workspace-down;
        "Super+TouchpadScrollUp".action = focus-workspace-up;
        "Super+TouchpadScrollDown".action = focus-workspace-down;
        ## Collumns
        "Super+TouchpadScrollRight".action = focus-column-right;
        "Super+TouchpadScrollLeft".action = focus-column-left;

        "Super+Shift+TouchpadScrollRight".action = move-column-right;
        "Super+Shift+TouchpadScrollLeft".action = move-column-left;
        # Workspaces
        "Super+1".action.focus-workspace = 1;
        "Super+2".action.focus-workspace = 2;
        "Super+3".action.focus-workspace = 3;
        "Super+Shift+1".action.move-column-to-workspace = 1;
        "Super+Shift+2".action.move-column-to-workspace = 2;
        "Super+Shift+3".action.move-column-to-workspace = 3;
        # Switches focus between the current and the previous workspace.

        # "Super+Tab".action = focus-workspace-previous;

        "Super+Comma".action = consume-window-into-column;
        "Super+Period".action = expel-window-from-column;
        # There are also commands that consume or expel a single window to the side.
        "Super+BracketLeft".action = consume-or-expel-window-left;
        "Super+BracketRight".action = consume-or-expel-window-right;
        # Resize

        "Super+R".action = switch-preset-column-width;
        "Super+Alt+F".action = maximize-column;
        "Super+Alt+C".action = center-column;
        "Super+Shift+F".action = fullscreen-window;
        "Super+Ctrl+Shift+F".action = toggle-windowed-fullscreen;

        "Alt+Ctrl+Left".action = set-column-width "-10%";
        "Alt+Ctrl+Right".action = set-column-width "+10%";

        "Alt+Ctrl+Up".action = set-window-height "-10%";
        "Alt+Ctrl+Down".action = set-window-height "+10%";

        "Super+Ctrl+Shift+Q".action = quit;

        "Super+Shift+P".action = power-off-monitors;
        # Knob binds

        ## Brightness with a knob
        "Super+XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action = spawn [

            "brightnessctl"
            "set"
            "2%+"
          ];
        };
        "Super+XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action = spawn [
            "brightnessctl"
            "set"
            "2%-"
          ];
        };

        ## Change mpd track with a knob
        "Shift+Alt+XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action = spawn [
            "mpc"
            "next"
          ];
        };
        "Shift+Alt+XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action = spawn [
            "mpc"
            "prev"
          ];
        };
        "Shift+Alt+XF86AudioMute" = {
          allow-when-locked = true;
          action = spawn [
            "mpc"
            "shuffle"
          ];
        };

        ## Change collumn size with a knob
        "Alt+Ctrl+XF86AudioRaiseVolume".action = set-column-width "+1%";
        "Alt+Ctrl+XF86AudioLowerVolume".action = set-column-width "-1%";
        "Alt+Ctrl+XF86AudioMute".action = switch-preset-column-width;
      };
    };
  };
}
