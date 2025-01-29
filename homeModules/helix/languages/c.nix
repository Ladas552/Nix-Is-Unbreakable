{ pkgs, ... }:

{

  programs.helix = {
    extraPackages = [ pkgs.clang-tools ];
  };
}
