{ lib, config, ... }:

{
  options.customhm = {
    mako.enable = lib.mkEnableOption "enable mako";
  };
  config = lib.mkIf config.customhm.mako.enable {
    services.mako = {
      enable = true;
      settings = {
        layer = "overlay";
        defaultTimeout = 5000;
        height = 1000;
      };
    };
  };
}
