{ lib, config, ... }:

{

  options.customhm = {
    tui-tools.enable = lib.mkEnableOption "enable tui-tools";
  };
  config = lib.mkIf config.customhm.tui-tools.enable {
    programs.ripgrep = {
      enable = true;
    };
    programs.fzf = {
      enable = true;
      enableFishIntegration = true;
    };
    programs.fd = {
      enable = true;
    };
    programs.btop = {
      enable = true;
    };
    programs.eza = {
      enable = true;
      enableFishIntegration = true;
      extraOptions = [ "--icons" ];
    };
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
