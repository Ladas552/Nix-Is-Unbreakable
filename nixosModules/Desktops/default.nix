{
  pkgs,
  lib,
  config,
  meta,
  ...
}:
{
  # a custom option for defining greetD command and autolaunch it later
  options.custom.greetd.command = lib.options.mkOption {
    default = "${lib.meta.getExe' pkgs.fish "fish"}";
    description = "The binary to use on greetD launch";
    type = lib.types.str;
  };
  # importing the Desktop environment modules
  imports = [
    # ./niri/flake
    ./niri/bare
    ./xfce
    ./bspwm
    ./wayfire
    ./labwc
    ./cage/ghostty.nix
    ./cage/cagebreak.nix
  ];

  config = lib.mkIf (!config.custom.lightdm.enable) {
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "${meta.user}";
    services.greetd = {
      enable = true;
      settings = rec {
        # initial session for autologin
        # https://wiki.archlinux.org/title/Greetd#Enabling_autologin
        initial_session = {
          command = "${config.custom.greetd.command}";
          user = "${meta.user}";
        };
        default_session = initial_session;
      };
    };

    # This is just a memento, not used
    # How to write a custom sessions for display manager
    # services.displayManager.sessionPackages = [
    #   (
    #     (pkgs.writeTextDir "share/wayland-sessions/niri.desktop" ''
    #       [Desktop Entry]
    #       Name=Niri
    #       Comment=why not
    #       Exec=${pkgs.niri}/bin/niri
    #       Type=Application
    #     '').overrideAttrs
    #     (_: {
    #       passthru.providedSessions = [ "niri" ];
    #     })
    #   )
    # ];
  };
}
