{
  lib,
  config,
  pkgs,
  ...
}:

{

  options.customhm.shell = {
    fish.enable = lib.mkEnableOption "enable fish";
  };
  config = lib.mkIf config.customhm.shell.fish.enable {
    programs.fish = {
      enable = true;
      shellInit = # fish
        ''
          set -gx pure_show_system_time true
          set -gx pure_color_system_time FF78C5
          abbr --set-cursor --command nix rn run nixpkgs#%
          abbr --set-cursor --command nix bn build nixpkgs#%
          abbr --set-cursor --command nix sn shell nixpkgs#%
          abbr --set-cursor --command nix rg run github:%
          abbr --set-cursor --command nix bg build github:%
          abbr --set-cursor --command nix sg shell github:%
          abbr --set-cursor --command nix nr run nixpkgs#%
          abbr --set-cursor --command nix nb build nixpkgs#%
          abbr --set-cursor --command nix ns shell nixpkgs#%
          abbr --set-cursor --command nix gr run github:%
          abbr --set-cursor --command nix gb build github:%
          abbr --set-cursor --command nix gs shell github:%
        '';
      plugins = with pkgs.fishPlugins; [
        {
          name = "autopair";
          src = autopair.src;
        }
        {
          name = "bass";
          src = bass.src;
        }
        {
          name = "pure";
          src = pure.src;
        }
        {
          name = "done";
          src = done.src;
        }
        {
          name = "puffer";
          src = puffer.src;
        }
        {
          name = "sponge";
          src = sponge.src;
        }
      ];
      preferAbbrs = true;
      shellAbbrs = config.home.shellAliases;
    };
  };
}
