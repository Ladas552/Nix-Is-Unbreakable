{pkgs, lib, config, inputs, ...}:

{

  options.customhm = {
    qutebrowser.enable = lib.mkEnableOption "enable qutebrowser";
  };
  config = lib.mkIf config.customhm.qutebrowser.enable {
    programs.qutebrowser = {
      enable = true;
    };
  };
}
