{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom = {
    karakeep.enable = lib.mkEnableOption "enable karakeep, bookmark manager";
  };

  config = lib.mkIf config.custom.karakeep.enable {

    services.karakeep = {
      enable = true;
      browser.exe = "${lib.getExe' pkgs.ungoogled-chromium "chromium"}";
      extraEnvironment = {
        PORT = "9221";
        DISABLE_SIGNUPS = "true";
        OCR_LANGS = "eng,rus";
        INFERENCE_ENABLE_AUTO_TAGGING = "false";
      };
    };
    networking.firewall.interfaces.ztcfwrb2q6.allowedTCPPorts = lib.mkIf config.custom.zerotier.enable [
      9222
      9221
    ]; # Only allow ZeroTier
    networking.firewall.interfaces.tailscale0.allowedTCPPorts =
      lib.mkIf config.custom.tailscale.enable
        [
          9222
          9221
        ]; # Only allow Tailscale
  };
}
