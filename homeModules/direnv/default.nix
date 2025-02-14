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
    home.packages = [ pkgs.devenv ];
    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
      config = {
        global = {
          warn_timeout = "0";
          hide_env_diff = true;
        };
      };
    };
  };
}
