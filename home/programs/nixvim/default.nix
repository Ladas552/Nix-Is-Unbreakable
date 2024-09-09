{ lib, config, pkgs, inputs, ... }:
{
  options.customhm = {
    nixvim.enable = lib.mkEnableOption "enable nixvim";
  };

  imports = [
    ./nvim/neorg.nix
    ./nvim/option.nix
    ./nvim/keymaps.nix
    ./nvim/plugins.nix
    ./nvim/colorscheme.nix
    inputs.nixvim.homeManagerModules.nixvim
  ];
  config = lib.mkIf config.customhm.nixvim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
    };
  };
}
