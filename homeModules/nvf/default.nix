{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.customhm = {
    nvf.enable = lib.mkEnableOption "enable nvf";
  };

  config = lib.mkIf config.customhm.nvf.enable {
    home.packages = [ pkgs.custom.nvf ];
    home.sessionVariables = lib.mkDefault {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };
  };
}
