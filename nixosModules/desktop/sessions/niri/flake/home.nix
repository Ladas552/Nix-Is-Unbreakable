{
  lib,
  pkgs,
  config,
  inputs,
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
      outputs."HDMI-A-1".scale = 2.0;
      hotkey-overlay.skip-at-startup = true;
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/screenshots/Niri%Y-%m-%d %H-%M-%S.png";
      spawn-at-startup = [
        { command = [ "wpaperd" ]; }
        {
          command = [
            "thunar"
            "-d"
          ];
        }
      ];
      # attribute sets
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
        center-focused-column = "on-overflow";
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
        preset-column-widths = [
          { proportion = 0.25; }
          { proportion = 0.5; }
          { proportion = 0.75; }
          { proportion = 1.0; }
        ];
      };
      # Window Rules
      window-rules = [
        {
          matches = [
            { app-id = ".qemu-system-x86_64-wrapped"; }
            { app-id = "vesktop"; }
            { app-id = "steam_app_0"; }
          ];
          open-fullscreen = true;
        }
        {
          matches = [ { app-id = "steam_proton"; } ];
          default-column-width = { };
        }
        {
          matches = [
            { app-id = "darksoulsii.exe"; }
            { app-id = "steam-"; }
            { title = "DARK SOULS II"; }
          ];
          open-fullscreen = true;
          variable-refresh-rate = false;
        }
        {
          matches = [ { app-id = "floorp"; } ];
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
        {
          matches = [
            { app-id = ''r#"^org\.keepassxc\.KeePassXC$"#''; }
            { app-id = ''r#"^org\.gnome\.World\.Secrets$"#''; }
          ];
          block-out-from = "screencast";
        }
      ];
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
          "ncmpcpp"
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
        "Shift+Alt+P".action = spawn [
          "mpc"
          "toggle"
        ];
        "Shift+Alt+P".allow-when-locked = true;
        "Shift+Alt+N".action = spawn [
          "mpc"
          "next"
        ];
        "Shift+Alt+N".allow-when-locked = true;
        "Shift+Alt+B".action = spawn [
          "mpc"
          "prev"
        ];
        "Shift+Alt+B".allow-when-locked = true;
        "Shift+Alt+K".action = spawn [
          "mpc"
          "volume"
          "-5"
        ];
        "Shift+Alt+K".allow-when-locked = true;
        "Shift+Alt+L".action = spawn [
          "mpc"
          "volume"
          "+5"
        ];
        "Shift+Alt+L".allow-when-locked = true;
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
        "XF86AudioRaiseVolume".action = spawn [
          "wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.02+"
        ];
        "XF86AudioRaiseVolume".allow-when-locked = true;
        "XF86AudioLowerVolume".action = spawn [
          "wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.02-"
        ];
        "XF86AudioLowerVolume".allow-when-locked = true;
        "XF86AudioMute".action = spawn [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SINK@"
          "toggle"
        ];
        "XF86AudioMute".allow-when-locked = true;
        "XF86AudioMicMute".action = spawn [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SOURCE@"
          "toggle"
        ];
        "XF86AudioMicMute".allow-when-locked = true;

        # shows a list of important hotkeys.
        "Mod+Shift+T".action = show-hotkey-overlay;
        # Screenshots
        "Print".action = screenshot;
        "Shift+Print".action = screenshot-screen;
        "Alt+Print".action = screenshot-window;
        # Window Management
        "Mod+Q".action = close-window;

        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-window-down;
        "Mod+Up".action = focus-window-up;
        "Mod+Right".action = focus-column-right;
        "Mod+A".action = focus-column-left;
        "Mod+S".action = focus-column-right;

        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Down".action = move-window-down;
        "Mod+Shift+Up".action = move-window-up;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Shift+A".action = move-column-left;
        "Mod+Shift+S".action = move-column-right;
        "Mod+Ctrl+H".action = move-column-left;
        "Mod+Ctrl+J".action = move-window-down;
        "Mod+Ctrl+K".action = move-window-up;
        "Mod+Ctrl+L".action = move-column-right;

        "Mod+Page_Up".action = focus-column-first;
        "Mod+Page_Down".action = focus-column-last;
        "Mod+Shift+Page_Up".action = move-column-to-first;
        "Mod+Shift+Page_Down".action = move-column-to-last;

        "Mod+Alt+H".action = focus-monitor-left;
        "Mod+Alt+J".action = focus-monitor-down;
        "Mod+Alt+K".action = focus-monitor-up;
        "Mod+Alt+L".action = focus-monitor-right;

        "Mod+Shift+Ctrl+Left".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+Down".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+Up".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+Right".action = move-column-to-monitor-right;
        "Mod+Shift+Ctrl+H".action = move-column-to-monitor-left;
        "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
        "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
        "Mod+Shift+Ctrl+L".action = move-column-to-monitor-right;

        "Mod+Ctrl+A".action = focus-workspace-up;
        "Mod+Ctrl+S".action = focus-workspace-down;

        "Mod+Shift+Ctrl+A".action = move-column-to-workspace-up;
        "Mod+Shift+Ctrl+S".action = move-column-to-workspace-down;

        "Mod+WheelScrollDown".action = focus-workspace-down;
        "Mod+WheelScrollDown".cooldown-ms = 150;
        "Mod+WheelScrollUp".action = focus-workspace-up;
        "Mod+WheelScrollUp".cooldown-ms = 150;
        "Mod+Ctrl+WheelScrollDown".action = move-column-to-workspace-down;
        "Mod+Ctrl+WheelScrollDown".cooldown-ms = 150;
        "Mod+Ctrl+WheelScrollUp".action = move-column-to-workspace-up;
        "Mod+Ctrl+WheelScrollUp".cooldown-ms = 150;

        "Mod+WheelScrollRight".action = focus-column-right;
        "Mod+WheelScrollLeft".action = focus-column-left;
        "Mod+Ctrl+WheelScrollRight".action = move-column-right;
        "Mod+Ctrl+WheelScrollLeft".action = move-column-left;

        "Mod+Shift+WheelScrollDown".action = focus-column-right;
        "Mod+Shift+WheelScrollUp".action = focus-column-left;
        "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
        "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;

        # Workspaces
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        # Switches focus between the current and the previous workspace.

        "Mod+Tab".action = focus-workspace-previous;

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

        "Mod+Ctrl+Left".action = set-column-width "-10%";
        "Mod+Ctrl+Right".action = set-column-width "+10%";

        "Mod+Ctrl+Up".action = set-window-height "-10%";
        "Mod+Ctrl+Down".action = set-window-height "+10%";

        "Mod+Ctrl+Shift+Q".action = quit;

        "Mod+Shift+P".action = power-off-monitors;
      };
    };
  };
}
