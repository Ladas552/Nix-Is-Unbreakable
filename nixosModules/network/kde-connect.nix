{ config, lib, ... }:

{
  options.custom = {
    kde-connect.enable = lib.mkEnableOption "enable kde-connect";
  };

  config = lib.mkIf config.custom.kde-connect.enable {
    programs.kdeconnect.enable = true;
  };
}
