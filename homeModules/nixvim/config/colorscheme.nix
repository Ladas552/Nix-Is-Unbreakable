{ lib, config, ... }:
{
  options.customhm = {
    nixvim.colorschemes.catppuccin = lib.mkEnableOption "enable catppuccin colorscheme";
  };

  config =
    lib.mkIf (config.customhm.nixvim.enable && config.customhm.nixvim.colorschemes.catppuccin)
      {

        programs.nixvim = {
          colorschemes.catppuccin = {
            enable = true;
            settings.flavour = "macchiato"; # "mocha"; darker
          };
        };
      };
}
