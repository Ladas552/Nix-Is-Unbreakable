{pkgs, lib, config, inputs, ...}:

{

  options.customhm = {
    ripgrep.enable = lib.mkEnableOption "enable ripgrep";
  };
  config = lib.mkIf config.customhm.ripgrep.enable {
    programs.ripgrep = {
      enable = true;
    };
  };
}
