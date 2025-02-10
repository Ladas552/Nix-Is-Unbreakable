{
  lib,
  config,
  pkgs,
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
    ./config/option.nix
    ./config/keymaps.nix
    ./config/neorg.nix
    ./config/full-plugins.nix
    ./config/mobile-plugins.nix
    ./config/colorscheme.nix
    inputs.nixvim.homeManagerModules.nixvim
  ];
  config = lib.mkIf config.customhm.nixvim.enable {

    programs.nixvim = {
      enable = true;
      enableMan = false;
      package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      defaultEditor = lib.mkDefault true;
      # Performance
      performance = {
        byteCompileLua = {
          enable = true;
          nvimRuntime = true;
          plugins = true;
        };
      };
    };
    home.sessionVariables = lib.mkDefault {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };
  };
}
