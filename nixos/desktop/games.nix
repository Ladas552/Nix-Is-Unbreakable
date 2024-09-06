{config, lib, pkgs, inputs, ...}:

{
  options.custom = {
    games.enable = lib.mkEnableOption "enable games";
  };

  imports = [
    inputs.aagl.nixosModules.default
  ];

  config = lib.mkIf config.custom.games.enable {
    # Genshin Imapct
    programs.sleepy-launcher.enable = true;
    # Steam
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
      #   extraCompatPackages = [pkgs.proton-ge-bin.steamcompattool];
    };
    hardware.steam-hardware.enable = true;
    environment.sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    programs.gamemode.enable = true;
    environment.systemPackages = with pkgs; [
      # Launchers
      heroic
      prismlauncher
      bottles
      # PC games
      osu-lazer-bin
      stepmania
      openmw
      # Utilities
      xclicker
      # Dependencies
      winePackages.stagingFull
      winePackages.fonts
      winetricks
      steam-run
      # Emulators
      duckstation
      mgba
      # doesn't work       retroarchFull
      # too complex and need a special controller      mame
    ];
  };
}
