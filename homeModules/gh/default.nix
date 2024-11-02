{ lib, config, ... }:

{

  options.customhm = {
    gh.enable = lib.mkEnableOption "enable gh";
  };

  config = lib.mkIf config.customhm.gh.enable {
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}
