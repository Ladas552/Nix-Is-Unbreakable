{
  lib,
  pkgs,
  config,
  inputs,
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
      outputs."eDP-1".scale = if meta.host == "NixPort" then 2.0 else 1.0;
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
          scroll-factor = 0.2;
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
        # Full screen/size apps
        {
          matches = [ { app-id = "steam_proton"; } ];
          default-column-width = { };
        }
        {
          matches = [
            { app-id = ".qemu-system-x86_64-wrapped"; }
            { app-id = "vesktop"; }
            { app-id = "steam_app_0"; }
            { app-id = "darksoulsii.exe"; }
            { app-id = "steam-"; }
            { title = "DARK SOULS II"; }
          ];
          open-fullscreen = true;
          default-column-width.proportion = 1.0;
        }
        {
          matches = [
            { app-id = "floorp"; }
            { app-id = "thunderbird"; }
          ];
          open-maximized = true;
        }
        {
          matches = [
            {
              app-id = "osu!";
              title = "osu!";
            }
          ];
          default-column-width.proportion = 1.0;
          open-maximized = true;
          focus-ring.enable = false;
          variable-refresh-rate = false;
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
          focus-ring = {
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
        "Super+E".action = spawn "emacs";
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
        # GUI apps
        "Super+F".action = spawn "thunar";
        "Super+W".action = spawn "floorp";
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

        "Mod+XF86AudioRaiseVolume" = {
          action = spawn [
            "brightnessctl"
            "set"
            "2%+"
          ];
          allow-when-locked = true;
        };
        "Mod\+XF86AudioLowerVolume" = {
          action = spawn [
            "brightnessctl"
            "set"
            "2%-"
          ];
          allow-when-locked = true;
        };
        # shows a list of important hotkeys.
        "Mod+Shift+T".action = show-hotkey-overlay;
        # Screenshots
        # was testing if it got better quility
        # "Print".action = spawn [
        #   "sh"
        #   "-c"
        #   "${lib.getExe pkgs.slurp} | ${lib.getExe pkgs.grim} -g -"
        # ];
        "Print".action = screenshot;
        # idk, broke on new flaek udpate
        # "Shift+Print".action = screenshot-screen;
        "Alt+Print".action = screenshot-window;
        # Window Management
        "Mod+Q".action = close-window;
        # Floating Windows
        "Ctrl+Alt+S".action = toggle-window-floating;
        "Mod+Tab".action = switch-focus-between-floating-and-tiling;
        # Tabbed layout
        "Ctrl+Alt+A".action = toggle-column-tabbed-display;

        "Mod+Left".action = focus-column-left-or-last;
        "Mod+Down".action = focus-window-down-or-top;
        "Mod+Up".action = focus-window-up-or-bottom;
        "Mod+Right".action = focus-column-right-or-first;
        "Mod+A".action = focus-column-left-or-last;
        "Mod+S".action = focus-column-right-or-first;

        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Down".action = move-window-down;
        "Mod+Shift+Up".action = move-window-up;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+A".action = move-column-left;
        "Mod+Shift+S".action = move-column-right;
        # "Mod+Ctrl+H".action = move-column-left;
        # "Mod+Ctrl+J".action = move-window-down;
        # "Mod+Ctrl+K".action = move-window-up;
        # "Mod+Ctrl+L".action = move-column-right;

        "Mod+Page_Up".action = focus-column-first;
        "Mod+Page_Down".action = focus-column-last;
        "Mod+Shift+Page_Up".action = move-column-to-first;
        "Mod+Shift+Page_Down".action = move-column-to-last;

        "Mod+Ctrl+Right".action = focus-monitor-right;
        "Mod+Ctrl+Down".action = focus-monitor-down;
        "Mod+Ctrl+Up".action = focus-monitor-up;
        "Mod+Ctrl+Left".action = focus-monitor-left;

        "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "Mod+Shift+H".action = move-column-to-monitor-left;
        "Mod+Shift+J".action = move-column-to-monitor-down;
        "Mod+Shift+K".action = move-column-to-monitor-up;
        "Mod+Shift+L".action = move-column-to-monitor-right;

        "Mod+Ctrl+A".action = focus-workspace-up;
        "Mod+Ctrl+S".action = focus-workspace-down;

        "Mod+Shift+Ctrl+A".action = move-column-to-workspace-up;
        "Mod+Shift+Ctrl+S".action = move-column-to-workspace-down;
        # Mouse scroll
        "Mod+WheelScrollDown" = {
          action = focus-workspace-down;
          cooldown-ms = 150;
        };
        "Mod+WheelScrollUp" = {
          action = focus-workspace-up;
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          action = move-column-to-workspace-down;
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          action = move-column-to-workspace-up;
          cooldown-ms = 150;
        };

        "Mod+WheelScrollRight".action = focus-column-right;
        "Mod+WheelScrollLeft".action = focus-column-left;
        "Mod+Ctrl+WheelScrollRight".action = move-column-right;
        "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

        "Mod+Shift+WheelScrollDown".action = focus-column-right;
        "Mod+Shift+WheelScrollUp".action = focus-column-left;
        "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
        "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

        # Touchpad gestures
        ## Workspaces
        "Mod+Shift+TouchpadScrollUp".action = move-column-to-workspace-up;
        "Mod+Shift+TouchpadScrollDown".action = move-column-to-workspace-down;
        "Mod+TouchpadScrollUp".action = focus-workspace-up;
        "Mod+TouchpadScrollDown".action = focus-workspace-down;
        ## Collumns
        "Mod+TouchpadScrollRight".action = focus-column-right;
        "Mod+TouchpadScrollLeft".action = focus-column-left;

        "Mod+Shift+TouchpadScrollRight".action = move-column-right;
        "Mod+Shift+TouchpadScrollLeft".action = move-column-left;
        # Workspaces
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        # Switches focus between the current and the previous workspace.

        # "Mod+Tab".action = focus-workspace-previous;

        "Mod+Comma".action = consume-window-into-column;
        "Mod+Period".action = expel-window-from-column;
        # There are also commands that consume or expel a single window to the side.
        "Mod+BracketLeft".action = consume-or-expel-window-left;
        "Mod+BracketRight".action = consume-or-expel-window-right;
        # Resize

        "Mod+R".action = switch-preset-column-width;
        "Mod+Alt+F".action = maximize-column;
        "Mod+Alt+C".action = center-column;
        "Mod+Shift+F".action = fullscreen-window;

        "Alt+Ctrl+Left".action = set-column-width "-10%";
        "Alt+Ctrl+Right".action = set-column-width "+10%";

        "Alt+Ctrl+Up".action = set-window-height "-10%";
        "Alt+Ctrl+Down".action = set-window-height "+10%";

        "Mod+Ctrl+Shift+Q".action = quit;

        "Mod+Shift+P".action = power-off-monitors;
      };
    };
  };
}
