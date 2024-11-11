{
  lib,
  config,
  ...
}:

{

  options.customhm = {
    lf.enable = lib.mkEnableOption "enable lf";
  };

  imports = [
    ./options/settings.nix
  ];

  config = lib.mkIf config.customhm.lf.enable {
    programs.lf = {
      enable = true;
    };
  };
}
