{ pkgs, lib }:
# It is a one liner to replace xpick on Wayland. Compatible with Wlroots. Doesn't need dependencies outside of ImageMagick that already declared in host
pkgs.writeShellScriptBin "wpick" # bash
  ''
    ${lib.getExe' pkgs.grim "grim"} -g "$(${lib.getExe' pkgs.slurp "slurp"} -p)" -t ppm - | ${lib.getExe' pkgs.imagemagick "magick"} - -format '%[pixel:p{0,0}]' txt:-
  ''
