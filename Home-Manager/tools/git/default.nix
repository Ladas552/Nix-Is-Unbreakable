{ config, pkgs, inputs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Ladas552";
    userEmail = "l.tokshalov@gmail.com";
  };
}
