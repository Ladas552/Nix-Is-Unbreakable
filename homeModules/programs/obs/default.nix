{lib, config, pkgs, ...}:
{
  options.customhm = {
    obs.enable = lib.mkEnableOption "enable obs";
  };

  config = lib.mkIf config.customhm.obs.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vkcapture
        input-overlay
        droidcam-obs
      ];
    };
  };
}
