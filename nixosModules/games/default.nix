{
  config,
  lib,
  pkgs,
  pkgs-master,
  inputs,
  meta,
  ...
}:

{
  options.custom = {
    games.enable = lib.mkEnableOption "enable games";
  };

  config = lib.mkIf config.custom.games.enable {
    # Steam
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      # gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin.steamcompattool ];
    };
    hardware.steam-hardware.enable = true;
    environment.sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    programs.gamemode.enable = true;
    environment.systemPackages =
      with pkgs;
      [
        # Launchers
        # PC games
        inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
        # stepmania
        openmw
        daggerfall-unity
        mindustry
        # Utilities
        # xclicker
        # Dependencies
        steam-run
        # Emulators
        duckstation
        blastem
        mgba
        snes9x-gtk
        punes
        melonDS
        # doesn't work       retroarchFull
        # too complex and need a special controller      mame
      ]
      ++ (lib.optionals (meta.host == "NixToks") [
        # Launchers
        bottles
        heroic
        prismlauncher
        # PC games
        arx-libertatis
        # Dependencies
        winePackages.stagingFull
        winetricks
      ]);
  };
}
