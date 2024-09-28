{ lib, config, ... }:

{

  options.customhm = {
    git.enable = lib.mkEnableOption "enable git";
  };

  config = lib.mkIf config.customhm.git.enable {
    programs.git = {
      enable = true;
      userName = "Ladas552";
      userEmail = "l.tokshalov@gmail.com";
      ignores = [
        ".pre-commit-config.yaml"
        "result"
        "result-bin"
        "result-man"
        "target"
        ".devenv"
        ".direnv"
      ];
    };
  };
}
