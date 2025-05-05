{
  lib,
  config,
  pkgs,
  inputs,
  meta,
  ...
}:

{
  options.customhm = {
    helix.enable = lib.mkEnableOption "enable helix";
  };

  imports = [
    ./languages
    ./config/keymap.nix
    ./config/options.nix
  ];

  config = lib.mkIf config.customhm.helix.enable {

    programs.helix = {
      enable = true;
      package = if meta.isTermux then pkgs.helix else inputs.helix-overlay.packages.x86_64-linux.default;
    };
  };
}
