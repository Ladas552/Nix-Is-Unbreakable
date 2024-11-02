{
  lib,
  config,
  inputs,
  ...
}:

{
  options.customhm = {
    helix.enable = lib.mkEnableOption "enable helix";
  };

  imports = [
    ./languages
    ./config/keymap.nix
    ./config/themes.nix
    ./config/options.nix
  ];

  config = lib.mkIf config.customhm.helix.enable {
    # overlay for helix flake. It will build from latest Helix commit
    #    nixpkgs = {
    #      overlays = [ inputs.helix-overlay.overlays.default ];
    #    };

    programs.helix = {
      enable = true;
    };
  };
}
