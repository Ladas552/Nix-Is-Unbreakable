{
  pkgs,
  inputs,
  config,
  lib,
  meta,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  imports = [ ./../../homeModules ];

  customhm = {
    foot.enable = true;
    fastfetch.enable = true;
    direnv.enable = true;
    gh.enable = true;
    lf.enable = true;
    nixvim.enable = true;
    shell.fish.enable = true;
  };
  # WSL isn't goot with switch for some reason
  home.shellAliases = {
    yy = lib.mkForce "nh os boot ${meta.self}";
    yyy = lib.mkForce "nh os boot -u ${meta.self}";
  };
  # Me
  home.username = "${meta.user}";
  home.homeDirectory = "/home/${meta.user}";
  # Don't change
  home.stateVersion = "24.05"; # Please read the comment before changing.
  # Standalone Packages for user
  home.packages = with pkgs; [
    libqalculate
    typst
  ];
  # Environment and Dependencies
  xdg = {
    enable = true;
  };

  home.sessionVariables = lib.mkForce {
    EDITOR = "nvim";
    VISUAL = "nvim";
    SUDO_EDITOR = "nvim";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
