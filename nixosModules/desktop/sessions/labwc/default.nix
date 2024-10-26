{ lib, config, ... }:

{

  options.custom = {
    labwc.enable = lib.mkEnableOption "enable labwc";
  };
  # imports = [./greetd.nix];
  config = lib.mkIf config.custom.labwc.enable {
    programs.labwc = {
      enable = true;
    };
  };
}
