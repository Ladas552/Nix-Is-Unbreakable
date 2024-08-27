{ config, lib, pkgs, inputs, ...}:

{

  imports = [
    ./nixvim/default.nix
    ./stilyx/graphics.nix
  ];
}
