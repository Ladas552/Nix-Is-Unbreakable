{
  lib,
  config,
  pkgs,
  ...
}:

{

  options.customhm = {
    direnv.enable = lib.mkEnableOption "enable direnv";
  };
  config = lib.mkIf config.customhm.direnv.enable {
    home.packages = [
      pkgs.devenv
    ];
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
