{
  lib,
  config,
  pkgs,
  meta,
  inputs,
  ...
}:
{
  options.customhm = {
    nvf.enable = lib.mkEnableOption "enable nvf";
  };

  imports = [
    inputs.nvf.homeManagerModules.default
    ./config/neorg.nix
    ./config/full-plugins.nix
  ];
  config = lib.mkIf config.customhm.nvf.enable {

    programs.nvf = {
      enable = true;
      # optimization
      settings.vim = {
        enableLuaLoader = true;
      };
    };
  };
}
