{pkgs, lib, config, inputs, ...}:

{

  options.customhm = {
    btop.enable = lib.mkEnableOption "enable btop";
  };
  config = lib.mkIf config.customhm.btop.enable {
    programs.btop = {
      enable = true;
    };
  };
}
