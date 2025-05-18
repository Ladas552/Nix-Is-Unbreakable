{
  lib,
  config,
  pkgs,
  ...
}:

{

  options.custom = {
    wayfire.enable = lib.mkEnableOption "enable wayfire";
  };

  config = lib.mkIf config.custom.wayfire.enable {
    # init Wayfire session
    custom.greetd.command = "${lib.meta.getExe' pkgs.wayfire "wayfire"}";

    programs.wayfire = {
      enable = true;
      # xwayland.enable = false;
    };
  };
}
