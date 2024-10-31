{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom = {
    nix-helper.enable = lib.mkEnableOption "enable nix-helper";
  };

  config = lib.mkIf config.custom.nix-helper.enable {

    # nix helper not available in HomeM right now
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.dates = "2 d";
    };
  };
}
