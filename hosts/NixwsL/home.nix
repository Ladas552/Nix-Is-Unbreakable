{
  pkgs,
  pkgs-stable,
  inputs,
  meta,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  imports = [ ./../../homeModules ];

  customhm = {
    shell.enable = false;
    nixvim.plugins.Neorg = false;
    direnv.enable = true;
    gh.enable = true;
    ghostty.enable = true;
    helix.enable = true;
    yt-dlp.enable = true;
  };

  # Me
  home.username = "${meta.user}";
  home.homeDirectory = "/home/${meta.user}";
  # Don't change
  home.stateVersion = "24.05"; # Please read the comment before changing.
  # Standalone Packages for user
  home.packages = with pkgs; [
    #pkgs-stable
    inputs.ghostty.packages.x86_64-linux.default
    libqalculate
    manix
    typst
  ];
  # Environment and Dependencies
  xdg = {
    enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
