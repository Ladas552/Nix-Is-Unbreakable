{ config, lib, pkgs, ...}:

{
  options = {
    nix-helper.enable = lib.mkEnableOption "enable nix-helper";
  };

  config = lib.mkIf config.nix-helper.enable {

    # nix helper not available in HomeM right now
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.dates = "2 d";
    };
  };
}
