{
  pkgs,
  meta,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  imports = [ ./../../homeModules ];

  customhm = {
    ghostty.enable = true;
    direnv.enable = true;
    imv.enable = true;
    nixvim.enable = false;
    shell.fish.enable = true;
  };
  # Me
  home.username = "${meta.user}";
  home.homeDirectory = "/home/${meta.user}";
  # Don't change
  home.stateVersion = "23.11"; # Please read the comment before changing.
  # Standalone Packages for user
  home.packages = with pkgs; [
    #pgks-master.
    libqalculate
    lshw
    gparted
  ];

  xdg = {
    enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
