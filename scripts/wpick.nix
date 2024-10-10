{ pkgs, lib }:
pkgs.writeShellScriptBin "wpick" # bash
  ''
    ${lib.getExe pkgs.grim} -g "$(${lib.getExe pkgs.slurp} -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:-
  ''
