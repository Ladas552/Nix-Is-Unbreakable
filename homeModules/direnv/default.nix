{
  lib,
  config,
  pkgs,
  meta,
  ...
}:

{

  options.customhm = {
    direnv.enable = lib.mkEnableOption "enable direnv";
  };
  config = lib.mkIf config.customhm.direnv.enable {
    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
      config = {
        global = {
          warn_timeout = "0";
          hide_env_diff = true;
        };
        whitelist.prefix = [ "/home/${meta.user}/Projects" ];
      };
    };
  };
}
