{ pkgs, lib }:
let
  git = lib.getExe' pkgs.git "git";
in
# Adds `ass` subtitle files to mkv files and creates subdirectory for copied mkv files. Subtitles aren't burned into mkv, just added to the pool. Nice if you don't have subtitle fuzzy find in your Media Player
pkgs.writeShellScriptBin "gcp" # bash
  ''
    ${git} add --all; ${git} commit -m "$1"; ${git} push
  ''
