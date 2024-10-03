{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom = {
    thunar.enable = lib.mkEnableOption "enable thunar";
  };

  config = lib.mkIf config.custom.thunar.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-volman
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };
    services = {
      gvfs.enable = true;
      tumbler.enable = true;
    };
  };
}
