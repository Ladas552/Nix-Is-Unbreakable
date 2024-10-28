{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:

{
  options.customhm = {
    helix.enable = lib.mkEnableOption "enable helix";
  };
  imports = [ ./languages ];
  config = lib.mkIf config.customhm.helix.enable {
    # overlay for helix flake. It will build from latest Helix commit
    nixpkgs = {
      overlays = [ inputs.helix-overlay.overlays.default ];
    };

    programs.helix = {
      enable = true;
      extraPackages = [ pkgs.nixd ];
      settings = {
        editor = {
          line-number = "relative";
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "block";
          };
        };
        keys = {
          normal = { };
        };
      };
    };
  };
}
