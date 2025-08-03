{
  pkgs,
  lib,
  meta,
  ...
}:

{
  customhm = {
    mako.enable = lib.mkDefault true;
    swaylock.enable = lib.mkDefault true;
    wpaperd.enable = lib.mkDefault true;
  };
  home.file.".config/niri/config.kdl".text = # kdl
    ''
      // This config is in the KDL format: https://kdl.dev
      // "/-" comments out the following node.
      // Check the wiki for a full description of the configuration:
      // https://github.com/YaLTeR/niri/wiki/Configuration:-Overview
      output "eDP-1" {
          scale ${if (meta.host == "NixPort") then "1.5" else "1"}
      }

      output "HDMI-A-1" {
          scale 2.0
          // scale 1.0
          // mode "1920x1080@60.000"
      }

      environment {
        TERMINAL "ghostty"
        DISPLAY ":0"
        __NV_PRIME_RENDER_OFFLOAD "1"
        __GLX_VENDOR_LIBRARY_NAME "nvidia"
      }

      input {
        keyboard {
          xkb {
            layout "us,kz"
            options "grp:caps_toggle"
          }
          numlock
        }
        //Libinput method
        touchpad {
          tap
          // dwt
          // dwtp
          natural-scroll
          // scroll-method "edge"
          middle-emulation
          scroll-factor 1
          // accel-speed 0.2
          // accel-profile "flat"
        }

        mouse {
          // natural-scroll
          // accel-speed 0.2
          accel-profile "flat"
        }
        workspace-auto-back-and-forth
        mod-key "Alt"

        // Uncomment this to make the mouse warp to the center of newly focused windows.
        // warp-mouse-to-focus

        // Focus windows and outputs automatically when moving the mouse into them.
        // focus-follows-mouse
      }
      gestures {
        hot-corners {
          off
        }
      }

      // Settings that influence how windows are positioned and sized.
      // Find more information on the wiki:
      // https://github.com/YaLTeR/niri/wiki/Configuration:-Layout
      layout {
        gaps 4

        center-focused-column "never"

        preset-column-widths {
          proportion 0.25
          proportion 0.5
          proportion 0.75
          proportion 1.0
        }

        // You can change the default width of the new windows.
        default-column-width { proportion 0.5; }
        // If you leave the brackets empty, the windows themselves will decide their initial width.
        // default-column-width {}

        // You can change how the focus ring looks.
        focus-ring {
          // Uncomment this line to disable the focus ring.
          // off

          // How many logical pixels the ring extends out from the windows.
          width 4

          // Colors can be set in a variety of ways:
          // - CSS named colors: "red"
          // - RGB hex: "#rgb", "#rgba", "#rrggbb", "#rrggbbaa"
          // - CSS-like notation: "rgb(255, 127, 0)", rgba(), hsl() and a few others.

          // Color of the ring on the active monitor.
          // active-color "#7fc8ff"
          // active-color "#0060FF"

          // Color of the ring on inactive monitors.
          // inactive-color "#505050"
          // inactive-color "#7700AE"

          active-gradient from="#7700AE" to="#0060FF" angle=45

          // You can also color the gradient relative to the entire view
          // of the workspace, rather than relative to just the window itself.
          // To do that, set relative-to="workspace-view".
          //
          // inactive-gradient from="#505050" to="#808080" angle=45 relative-to="workspace-view"
        }

        // You can also add a border. It's similar to the focus ring, but always visible.
        border {
          // The settings are the same as for the focus ring.
          // If you enable the border, you probably want to disable the focus ring.
          off

          width 4
          // active-color "#ffc87f"
          // active-color "#0060FF"
          // inactive-color "#505050"
          inactive-color "#7700AE"
          active-gradient from="#7700AE" to="#0060FF" angle=45

          // active-gradient from="#ffbb66" to="#ffc880" angle=45 relative-to="workspace-view"
          // inactive-gradient from="#505050" to="#808080" angle=45 relative-to="workspace-view"
        }
        tab-indicator {
            hide-when-single-tab
            place-within-column
            gap -8.000000
            width 4.000000
            length total-proportion=0.100000
            position "right"
            gaps-between-tabs 10.000000
            corner-radius 10.000000
            active-color "#BA4B5D"
        }
        default-column-display "tabbed"

        // Struts shrink the area occupied by windows, similarly to layer-shell panels.
        // You can think of them as a kind of outer gaps. They are set in logical pixels.
        // Left and right struts will cause the next window to the side to always be visible.
        // Top and bottom struts will simply add outer gaps in addition to the area occupied by
        // layer-shell panels and regular gaps.
        struts {
          // left 64
          // right 64
          // top 64
          // bottom 64
        }
      }
      cursor {
          xcursor-theme "default"
          xcursor-size 24
          hide-after-inactive-ms 10000
      }

      hotkey-overlay {
        skip-at-startup
      }
      // No Decorations
      prefer-no-csd
      // You can change the path where screenshots are saved.
      // The path is formatted with strftime(3) to give you the screenshot date and time.
      screenshot-path "~/Pictures/screenshots/Niri%Y-%m-%d %H-%M-%S.png"

      // You can also set this to null to disable saving screenshots to disk.
      // screenshot-path null

      // Animation settings.
      // The wiki explains how to configure individual animations:
      // https://github.com/YaLTeR/niri/wiki/Configuration:-Animations
      animations {
        // Uncomment to turn off all animations.
        // off

        // Slow down all animations by this factor. Values below 1 speed them up instead.
        // slowdown 3.0
      }

      // Window rules let you adjust behavior for individual windows.
      // Find more information on the wiki:
      // https://github.com/YaLTeR/niri/wiki/Configuration:-Window-Rules

      // Make inactive windows semitransparent.
      // window-rule {
      //   match is-active=false
      //   opacity 0.80
      // }
      window-rule {
          match is-floating=true
          shadow { on; }
      }
      window-rule {
          match app-id="mpv"
          shadow { off; }
      }
      window-rule {
        match title="Picture-in-Picture"
        default-column-width { fixed 420; }
        default-window-height { fixed 236; }
        default-floating-position x=50 y=50 relative-to="bottom-right"
        open-focused false
        open-floating true
      }

      window-rule {
        // this is for software I run in Bottles
        match app-id="steam_proton"
        default-column-width {}
      }

      window-rule {
        match app-id=".qemu-system-x86_64-wrapped"
        match app-id="vesktop"
        match app-id="legcord"
        match app-id="steam_app_0"
        match app-id="darksoulsii.exe"
        match app-id="steam-"
        match title="DARK SOULS II"
        match app-id="osu!"
        match title="osu!"
        variable-refresh-rate false
        open-fullscreen true
        default-column-width { proportion 1.000000; }
      }

      window-rule {
        match app-id="librewolf"
        match app-id="thunderbird"

        open-maximized true
        // default-column-width { proportion 1.00; }
      }
      // Example: block out two password managers from screen capture.
      // (This example rule is commented out with a "/-" in front.)
      window-rule {
        match app-id=r#"^org\.keepassxc\.KeePassXC$"#
        match app-id=r#"^org\.gnome\.World\.Secrets$"#

        block-out-from "screencast"

        // Use this instead if you want them visible on third-party screenshot tools.
        // block-out-from "screencast"
      }
      window-rule {
          match is-window-cast-target=true
          border {
              on
              active-color "#BA4B5D"
              inactive-color "#BA4B5D"
          }
      }



      // Keybinds
      binds {
        // shows a list of important hotkeys.
        Super+Shift+T { show-hotkey-overlay; }

        // Apps

        Super+T { spawn "ghostty"; }
        // Super+Ctrl+T { spawn "kitty"; }
        Super+Space { spawn "rofi" "-show"; }
        Super+L { spawn "swaylock"; }
        Super+N {spawn "ghostty" "-e" "nvim";}
        Super+J {spawn "ghostty" "-e" "nvim" "-c" "Neorg journal today";}
        Super+M {spawn "ghostty" "-e" "rmpc";}
        Super+H {spawn "ghostty" "-e" "btop";}
        Super+G {spawn "ghostty" "-e" "qalc";}
        // You can also use a shell:
        // Super+T { spawn "bash" "-c" "notify-send hello && exec alacritty"; }

        // GUI apps
        Super+F { spawn "thunar"; }
        Super+W { spawn "librewolf"; }

        // MPD

        Shift+Alt+P allow-when-locked=true { spawn "mpc" "toggle"; }
        Shift+Alt+N allow-when-locked=true { spawn "mpc" "next"; }
        Shift+Alt+B allow-when-locked=true { spawn "mpc" "prev"; }
        Shift+Alt+K allow-when-locked=true { spawn "mpc" "volume" "-5"; }
        Shift+Alt+L allow-when-locked=true { spawn "mpc" "volume" "+5"; }
        Shift+Alt+C { spawn "mpc" "clear"; }
        Shift+Alt+M { spawn "musnow.sh"; }

        // Screenshots

        Print { screenshot; }
        Shift+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }

        // Scripts

        Super+C { spawn "word-lookup.sh"; }
        Super+X { spawn "powermenu.sh"; }

        // Example volume keys mappings for PipeWire & WirePlumber.
        // The allow-when-locked=true property makes them work even when the session is locked.
        // XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
        // XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }
        // XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }

        XF86AudioRaiseVolume allow-when-locked=true { spawn "pamixer" "-i" "2";}
        XF86AudioLowerVolume allow-when-locked=true { spawn "pamixer" "-d" "2";}
        XF86AudioMute        allow-when-locked=true { spawn "pamixer" "-t";}
        XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

        // Brightness
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "set" "10%-"; }
        XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "set" "10%+"; }

        // Window Management

        Super+Q { close-window; }
        // Tabbed
        Alt+Ctrl+A { toggle-column-tabbed-display; }
        // Floating
        Alt+Ctrl+S { toggle-window-floating; }
        Super+Tab { switch-focus-between-floating-and-tiling; }



        Super+Left  { focus-column-left-or-last; }
        Super+Down  { focus-window-down-or-top; }
        Super+Up    { focus-window-up-or-bottom; }
        Super+Right { focus-column-right-or-first; }
        Super+A     { focus-column-left-or-last; }
        Super+S     { focus-column-right-or-first; }
       // Super+J     { focus-window-down; }
       // Super+K     { focus-window-up; }

        Super+Shift+Left  { move-column-left; }
        Super+Shift+Down  { move-window-down; }
        Super+Shift+Up    { move-window-up; }
        Super+Shift+Right { move-column-right; }
        Super+Shift+A     { move-column-left; }
        Super+Shift+S     { move-column-right; }
        // Super+Ctrl+H      { move-column-left; }
        // Super+Ctrl+J      { move-window-down; }
        // Super+Ctrl+K      { move-window-up; }
        // Super+Ctrl+L      { move-column-right; }

        Super+Page_Up { focus-column-first; }
        Super+Page_Down  { focus-column-last; }
        Super+Shift+Page_Up { move-column-to-first; }
        Super+Shift+Page_Down  { move-column-to-last; }

        Super+Ctrl+Left     { focus-monitor-left; }
        Super+Ctrl+Down     { focus-monitor-down; }
        Super+Ctrl+Up     { focus-monitor-up; }
        Super+Ctrl+Right     { focus-monitor-right; }

        Super+Shift+Ctrl+Left  { move-column-to-monitor-left; }
        Super+Shift+Ctrl+Down  { move-column-to-monitor-down; }
        Super+Shift+Ctrl+Up    { move-column-to-monitor-up; }
        Super+Shift+Ctrl+Right { move-column-to-monitor-right; }
        Super+Shift+H     { move-column-to-monitor-left; }
        Super+Shift+J     { move-column-to-monitor-down; }
        Super+Shift+K     { move-column-to-monitor-up; }
        Super+Shift+L     { move-column-to-monitor-right; }

        // Super+Page_Up        { focus-workspace-up; }
        // Super+Page_Down      { focus-workspace-down; }
        Super+Ctrl+A         { focus-workspace-up; }
        Super+Ctrl+S         { focus-workspace-down; }
        // Super+Ctrl+Page_Up   { move-column-to-workspace-up; }
        // Super+Ctrl+Page_Down { move-column-to-workspace-down; }
        Super+Shift+Ctrl+A   { move-column-to-workspace-up; }
        Super+Shift+Ctrl+S   { move-column-to-workspace-down; }

        // Super+Shift+Page_Down { move-workspace-down; }
        // Super+Shift+Page_Up   { move-workspace-up; }

        Super+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Super+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Super+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Super+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

        Super+WheelScrollRight      { focus-column-right; }
        Super+WheelScrollLeft       { focus-column-left; }
        Super+Ctrl+WheelScrollRight { move-column-right; }
        Super+Ctrl+WheelScrollLeft  { move-column-left; }

        // Usually scrolling up and down with Shift in applications results in
        // horizontal scrolling; these binds replicate that.
        Super+Shift+WheelScrollDown      { focus-column-right; }
        Super+Shift+WheelScrollUp        { focus-column-left; }
        Super+Ctrl+Shift+WheelScrollDown { move-column-right; }
        Super+Ctrl+Shift+WheelScrollUp   { move-column-left; }

        // Touchpad gestures
        //// Workspaces
        Super+TouchpadScrollRight { focus-column-right; }
        Super+TouchpadScrollUp { focus-workspace-up; }

        Super+Shift+TouchpadScrollDown { move-column-to-workspace-down; }
        Super+Shift+TouchpadScrollUp { move-column-to-workspace-up; }


        //// Collumns
        Super+TouchpadScrollDown { focus-workspace-down; }
        Super+TouchpadScrollLeft { focus-column-left; }

        Super+Shift+TouchpadScrollLeft { move-column-left; }
        Super+Shift+TouchpadScrollRight { move-column-right; }


        // Worlspaces

        Super+1 { focus-workspace 1; }
        Super+2 { focus-workspace 2; }
        Super+3 { focus-workspace 3; }
        Super+Shift+1 { move-column-to-workspace 1; }
        Super+Shift+2 { move-column-to-workspace 2; }
        Super+Shift+3 { move-column-to-workspace 3; }

        // Switches focus between the current and the previous workspace.
        // Super+Tab { focus-workspace-previous; }

        Super+Comma  { consume-window-into-column; }
        Super+Period { expel-window-from-column; }

        // There are also commands that consume or expel a single window to the side.
        Super+BracketLeft  { consume-or-expel-window-left; }
        Super+BracketRight { consume-or-expel-window-right; }

        Super+R {       switch-preset-column-width; }
        Super+Alt+F {   maximize-column; }
        Super+Alt+C {   center-column; }
        Super+Shift+F { fullscreen-window; }
        Super+Ctrl+Shift+F { toggle-windowed-fullscreen; }

        // Finer width adjustments.
        // This command can also:
        // * set width in pixels: "1000"
        // * adjust width in pixels: "-5" or "+5"
        // * set width as a percentage of screen width: "25%"
        // * adjust width as a percentage of screen width: "-10%" or "+10%"
        // Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
        // set-column-width "100" will make the column occupy 200 physical screen pixels.
        Alt+Ctrl+Left { set-column-width "-10%"; }
        Alt+Ctrl+Right { set-column-width "+10%"; }

        // Finer height adjustments when in column with other windows.
        Alt+Ctrl+Up { set-window-height "-10%"; }
        Alt+Ctrl+Down { set-window-height "+10%"; }

        // Actions to switch layouts.
        // Note: if you uncomment these, make sure you do NOT have
        // a matching layout switch hotkey configured in xkb options above.
        // Having both at once on the same hotkey will break the switching,
        // since it will switch twice upon pressing the hotkey (once by xkb, once by niri).
        // Super+Space       { switch-layout "next"; }
        // Super+Shift+Space { switch-layout "prev"; }

        // The quit action will show a confirmation dialog to avoid accidental exits.
        Super+Ctrl+Shift+Q { quit; }

        // Powers off the monitors. To turn them back on, do any input like
        // moving the mouse or pressing any other key.
        Super+Shift+P { power-off-monitors; }

        // Knob binds

        /// Brightness with a knob
        Super+XF86AudioRaiseVolume allow-when-locked=true { spawn "brightnessctl" "set" "2%+"; }
        Super+XF86AudioLowerVolume allow-when-locked=true { spawn "brightnessctl" "set" "2%-"; }

        /// Change mpd track with a knob
        Shift+Alt+XF86AudioRaiseVolume allow-when-locked=true { spawn "mpc" "next"; }
        Shift+Alt+XF86AudioLowerVolume allow-when-locked=true { spawn "mpc" "prev"; }
        Shift+Alt+XF86AudioMute allow-when-locked=true { spawn "mpc" "shuffle"; }

        /// Change window focus with a knob
        /// dk if it's usable
        /// Ctrl+XF86AudioRaiseVolume { focus-window-down-or-column-right; }
        /// Ctrl+XF86AudioLowerVolume { focus-window-up-or-column-left; }

        /// Change collumn size with a knob
        Alt+Ctrl+XF86AudioRaiseVolume { set-column-width "+1%"; }
        Alt+Ctrl+XF86AudioLowerVolume { set-column-width "-1%"; }
        Alt+Ctrl+XF86AudioMute { switch-preset-column-width; }
      }

      // Switch events
      switch-events {
          lid-close { spawn "niri" "msg" "action" "power-off-monitors"; }
          lid-open { spawn "niri" "msg" "action" "power-on-monitors"; }
      }

      // AutoStart

      //spawn-at-startup "xfce4-panel"
      spawn-at-startup "thunar" "-d"
      spawn-at-startup "wpaperd"
      spawn-at-startup "xfce4-power-manager" "--daemon"
    '';
}
