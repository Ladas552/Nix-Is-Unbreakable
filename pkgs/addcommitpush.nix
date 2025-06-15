{ pkgs, lib }:
let
  git = lib.getExe' pkgs.git "git";
in
# Quick git alias
# gcp "your commit" to push new commit
pkgs.writeShellScriptBin "gcp" # bash
  ''
    ${git} add --all && ${git} commit -m "$1" && ${git} push
  ''
