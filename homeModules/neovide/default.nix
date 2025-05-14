{
  pkgs,
  lib,
  config,
  meta,
  ...
}:
{
  options.customhm = {
    neovide.enable = lib.mkEnableOption "enable neovide";
  };

  config = lib.mkIf config.customhm.neovide.enable {
    programs.neovide = {
      enable = true;
      settings = {
        font = {
          size = 13;
          normal = "JetBrainsMono NFM SemiBold";
        };
        vsync = false;
        srgb = true;
        wsl = lib.mkIf (meta.host == "NixwsL") true;

      };
    };
  };
}
