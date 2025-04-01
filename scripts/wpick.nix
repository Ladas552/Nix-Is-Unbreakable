{ pkgs, lib }:
# It is a one liner to replace xpick on Wayland. Compatible with Wlroots. Doesn't need dependencies outside of ImageMagick that already declared in host
pkgs.writeShellScriptBin "wpick" # bash
  ''
    ${lib.meta.getExe' pkgs.grim "grim"} -g "$(${lib.meta.getExe' pkgs.slurp "slurp"} -p)" -t ppm - | ${lib.meta.getExe' pkgs.imagemagick "magick"} - -format '%[pixel:p{0,0}]' txt:-
  ''
