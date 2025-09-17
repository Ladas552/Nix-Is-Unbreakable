{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom = {
    games.enable = lib.mkEnableOption "enable games";
  };
  imports = [ ./dosbox.nix ];
  config = lib.mkIf config.custom.games.enable {
    custom.games = {
      dosbox.enable = true;
    };
    # Steam
    programs.steam = {
      enable = false;
      remotePlay.openFirewall = true;
      # gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin.steamcompattool ];
    };
    hardware.steam-hardware.enable = true;
    environment.sessionVariables.STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    programs.gamemode.enable = false; # huge battery drains on my laptop
    environment.systemPackages = with pkgs; [
      # Launchers
      bottles
      # heroic
      # prismlauncher
      # PC games
      osu-lazer-bin
      # arx-libertatis
      # stepmania
      openmw
      daggerfall-unity
      # luanti
      raze
      vkquake
      # mindustry
      # Utilities
      # xclicker
      # Dependencies
      # winePackages.stagingFull
      # winetricks
      steam-run
      # Emulators
      # blastem
      # mgba
      # snes9x-gtk
      # punes
      # melonDS
      # doesn't work       retroarchFull
      # too complex and need a special controller      mame
    ];
  };
}
