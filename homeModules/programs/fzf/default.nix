{pkgs, lib, config, inputs, ...}:

{

  options.customhm = {
    fzf.enable = lib.mkEnableOption "enable fzf";
  };
  config = lib.mkIf config.customhm.fzf.enable {
    programs.fzf = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
