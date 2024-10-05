{
  lib,
  config,
  inputs,
  ...
}:
{
  options.customhm = {
    nixvim.enable = lib.mkEnableOption "enable nixvim";
  };

  imports = [
    # Neorg module only for overlay. Don't forget to reenable overlay in flake.nix
    # ./nvim/neorg.nix
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
    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };
  };
}
