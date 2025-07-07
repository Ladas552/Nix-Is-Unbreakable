{ pkgs, lib }:
# Quick git alias
# gcp "your commit" to push new commit
pkgs.writeShellScriptBin "gcp" # bash
  ''
    ${lib.meta.getExe' pkgs.git "git"} add --all && ${lib.meta.getExe' pkgs.git "git"} commit -m "$1" && ${lib.meta.getExe' pkgs.git "git"} push
  ''
