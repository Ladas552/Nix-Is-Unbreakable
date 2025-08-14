{
  config,
  lib,
  ...
}:

{
  options.custom = {
    nix-helper.enable = lib.mkEnableOption "enable nix-helper";
  };

  config = lib.mkIf config.custom.nix-helper.enable {

    # got direct support from developers, appose to HM version
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.dates = "2 d";
    };
  };
}
