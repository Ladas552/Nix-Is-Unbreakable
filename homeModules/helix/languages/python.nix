{ pkgs, ... }:

{
  programs.helix = {
    extraPackages = [
      pkgs.ruff
      pkgs.basedpyright
    ];
  };
}
