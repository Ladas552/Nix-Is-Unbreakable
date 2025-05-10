{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.customhm = {
    nixvim.enable = lib.mkEnableOption "enable nixvim";
  };

  config = lib.mkIf config.customhm.nixvim.enable {
    home.packages = [ pkgs.custom.nixvim ];
    home.sessionVariables = lib.mkDefault {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };
  };
}
