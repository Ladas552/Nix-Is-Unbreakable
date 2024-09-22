{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.customhm = {
    emacs.enable = lib.mkEnableOption "enable emacs";
  };

  config = lib.mkIf config.customhm.emacs.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-git-nox;
      extraPackages =
        epkgs: with pkgs.emacsPackages; [
          org
          zk
        ];
    };
    services.emacs.enable = true;
  };
}
