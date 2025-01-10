{
  lib,
  config,
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
      package = inputs.helix-overlay.packages.${meta.system}.default;
    };
  };
}
