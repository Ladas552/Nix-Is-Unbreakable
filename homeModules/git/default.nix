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
      extraConfig = {
        init.defaultBranch = "master";
        commit.gpgsign = true;
        gpg.format = "ssh";
        user.signingkey = "~/.ssh/NixToks.pub";
      };
      aliases = {
        cm = "commit -m";
        al = "add ./*";
      };
      ignores = [
        ".pre-commit-config.yaml"
        "result"
        "result-bin"
        "result-man"
        "target"
        ".direnv"
      ];
    };
  };
}
