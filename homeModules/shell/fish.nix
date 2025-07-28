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
      shellAbbrs =
        let
          # a little function to not write boilerplate
          nix = expansion: {
            setCursor = "%";
            command = "nix";
            expansion = expansion;
          };
        in
        {
          "bg" = nix "build github:%";
          "bn" = nix "build nixpkgs#%";
          "gb" = nix "build github:%";
          "gr" = nix "run github:%";
          "gs" = nix "shell github:%";
          "nb" = nix "build nixpkgs#%";
          "nr" = nix "run nixpkgs#%";
          "ns" = nix "shell nixpkgs#%";
          "rg" = nix "run github:%";
          "rn" = nix "run nixpkgs#%";
          "sg" = nix "shell github:%";
          "sn" = nix "shell nixpkgs#%";
        }
        // config.home.shellAliases;
    };
  };
}
