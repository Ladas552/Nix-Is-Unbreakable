{pkgs, lib, config, inputs, ...}:

{

  options.customhm = {
    fd.enable = lib.mkEnableOption "enable fd";
  };
  config = lib.mkIf config.customhm.fd.enable {
    programs.fd = {
      enable = true;
    };
  };
}
