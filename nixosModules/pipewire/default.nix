{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom = {
    pipewire.enable = lib.mkEnableOption "enable pipewire";
  };

  config = lib.mkIf config.custom.pipewire.enable {
    environment.systemPackages = [ pkgs.sbc ];
    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
    ### IT IS A LIE IT MAKES IT DEFAULT TO BAD CODEC I HATE THIS
    # "Make bluetoot work better"
    # services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
    #   "monitor.bluez.properties" = {
    #     "bluez5.enable-sbc-xq" = true;
    #     "bluez5.enable-msbc" = true;
    #     "bluez5.enable-hw-volume" = true;
    #     "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
    #   };
    # };

    # persist for Impermanence
    custom.imp.home.cache.directories = [ ".local/state/wireplumber" ];
  };
}
