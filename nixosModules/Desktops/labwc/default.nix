{
  lib,
  config,
  pkgs,
  ...
}:

{

  options.custom = {
    labwc.enable = lib.mkEnableOption "enable labwc";
  };

  config = lib.mkIf config.custom.labwc.enable {
    # init Labwc session
    custom.greetd.command = "${lib.meta.getExe' pkgs.labwc "labwc"}";
    programs.labwc = {
      enable = true;
    };
  };
}
