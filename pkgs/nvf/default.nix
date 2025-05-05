{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
{

  imports = [
    ./config/neorg.nix
    ./config/full-plugins.nix
  ];

  # optimization
  vim = {
    enableLuaLoader = true;
  };
}
