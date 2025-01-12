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
      package = inputs.helix-overlay.packages.${meta.system}.default;
      # This works, but needs to be fixed the nixpkgs side https://github.com/NixOS/nixpkgs/issues/373101
      # package = inputs.helix-overlay.packages.x86_64-linux.default or pkgs.helix;
    };
  };
}
