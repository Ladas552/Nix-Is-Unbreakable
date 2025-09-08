{
  lib,
  config,
  pkgs,
  meta,
  ...
}:
{
  options.customhm = {
    nixvim.enable = lib.mkEnableOption "enable nixvim";
  };

  config = lib.mkIf config.customhm.nixvim.enable {
    home.packages =
      [ ]
      ++ lib.optionals (!meta.isTermux) [ pkgs.custom.nixvim ]
      ++ lib.optionals meta.isTermux [ pkgs.custom.nixvim-minimal ];
    home.sessionVariables = lib.mkDefault {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };
  };
}
