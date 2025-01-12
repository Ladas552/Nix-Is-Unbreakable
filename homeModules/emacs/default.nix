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
      # pure gtk GUI for Emacs
      package = pkgs.emacs30-pgtk;
      # Settings defined in init.el file
      extraConfig = # commonlisp
        ''
          (load-theme 'catppuccin :no-confirm)
          (setq catppuccin-flavor 'macchiato)
          (catppuccin-reload)
        '';
      extraPackages =
        epkgs: with pkgs.emacsPackages; [
          # Org Mode
          org
          # Zettlekasten for org
          zk
          # Colorscheme
          catppuccin-theme
        ];
    };
    services.emacs.enable = true;
  };
}
