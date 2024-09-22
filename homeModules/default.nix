{ lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  imports = [
    ./programs
    ./environment
  ];

  customhm = {
    nixvim.enable = lib.mkDefault true;
    fish.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    ranger.enable = lib.mkDefault true;
    yazi.enable = lib.mkDefault true;
    vim.enable = lib.mkDefault true;
    tui-tools.enable = lib.mkDefault true;
    fastfetch.enable = lib.mkDefault true;
  };
}
