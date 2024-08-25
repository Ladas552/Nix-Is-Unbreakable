{ config, pkgs, lib, inputs, ... }:

{
  home.file.".config/niri/config.kdl" = {
    source = ./fileconfigs/config.kdl;
  };
}
