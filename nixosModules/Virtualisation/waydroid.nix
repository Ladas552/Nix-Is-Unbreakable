{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom = with lib; {
    waydroid.enable = mkEnableOption "enable waydroid";
  };

  config = lib.mkIf config.custom.waydroid.enable {
    virtualisation.waydroid.enable = true;

    # persist for Impermanence
    custom.imp.root.cache.directories = [ "/var/lib/waydroid" ];
  };
}
