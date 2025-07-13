{
  config,
  lib,
  meta,
  ...
}:

{
  options.custom = {
    immich.enable = lib.mkEnableOption "enable immich";
  };

  config = lib.mkIf config.custom.immich.enable {
    services.immich = {
      enable = true;
      openFirewall = true;
      mediaLocation = "/home/${meta.user}/Pictures";
    };
  };
}
