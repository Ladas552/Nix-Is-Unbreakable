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

  config = lib.mkIf config.customhm.helix.enable {
    # overlay for helix flake. It will build from latest Helix commit
    nixpkgs = {
      overlays = [ inputs.helix-overlay.overlays.default ];
    };

    programs.helix = {
      enable = true;
      settings = {
        editor = {
          line-number = "relative";
        };
        keys = {
          normal = { };
        };
      };
    };
  };
}
