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
          ;; default theme
          (load-theme 'catppuccin :no-confirm)
          (setq catppuccin-flavor 'macchiato)
          (catppuccin-reload)
          ;; Icons
          (when (display-graphic-p)
            (require 'all-the-icons))
          ;; Fonts

          ;; dashboard initialisation
          (require 'dashboard)
          (dashboard-setup-startup-hook)
          (require 'page-break-lines)

          ;; Set the title
          (setq dashboard-banner-logo-title "Time-Waste-Mode enabled")

          ;; Set the banner
          (setq dashboard-startup-banner 'logo)

          ;; Content is not centered by default. To center, set
          (setq dashboard-center-content t)

          ;; vertically center content
          (setq dashboard-vertically-center-content t)

          ;; items in dashboard
          (setq dashboard-items '((bookmarks . 15)
                        (agenda    . 5)))

          ;; enable cycle navigation between each section
          (setq dashboard-navigation-cycle t)

          ;; To use icons
          (setq dashboard-icon-type 'all-the-icons)          
          (setq dashboard-set-heading-icons nil) ; not `t` because some bug, idk
          (setq dashboard-set-file-icons t)

          ;; modify the widget heading name
          (setq dashboard-item-names '(("Agenda for the coming week:" . "Agenda:")))
          (setq dashboard-week-agenda t)

          ;; Hide modeline
          (add-hook 'dashboard-mode-hook (lambda () (setq-local mode-line-format nil)))

          ;; Add solaire integration
          (solaire-global-mode +1)
          (add-hook 'dashboard-before-initialize-hook #'solaire-mode)          
        '';
      extraPackages =
        epkgs: with pkgs.emacsPackages; [
          # Note Taking
          org # Org-mode
          zk # Zettlekasten for org
          # UI
          catppuccin-theme # colorscheme
          solaire-mode # color unreal bufferst darker
          all-the-icons # Icons like nerdfonts
          # Dashboard
          dashboard # new Start up buffer
          page-break-lines # pretty horizontal lines
        ];
    };
    services.emacs.enable = true;
  };
}
