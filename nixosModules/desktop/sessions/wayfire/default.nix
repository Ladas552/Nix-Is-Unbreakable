{ lib, config, ... }:

{

  options.custom = {
    wayfire.enable = lib.mkEnableOption "enable wayfire";
  };
  # imports = [./greetd.nix];
  config = lib.mkIf config.custom.wayfire.enable {
    programs.wayfire = {
      enable = true;
      xwayland.enable = false;
    };
  };
}
