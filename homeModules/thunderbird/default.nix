{ lib, config, ... }:

{
  options.customhm = {
    thunderbird.enable = lib.mkEnableOption "enable thunderbird";
  };
  config = lib.mkIf config.customhm.thunderbird.enable {
    programs.thunderbird = {
      enable = true;
      profiles."Ladas552" = {
        isDefault = true;
        settings = {
          "app.donation.eoy.version.viewed" = 999;
          "browser.aboutConfig.showWarning" = false;
          "browser.ping-centre.telemetry" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          #it breaks google account
          "javascript.enabled" = true;
          #"javascript.options.wasm" = false;
          "mail.chat.enabled" = false;
          "privacy.resistFingerprinting" = true;
          "security.warn_entering_weak" = true;
          "security.warn_leaving_secure" = true;
          "security.warn_viewing_mixed" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
        };
      };
    };

    # persist for Impermanence
    customhm.imp.home = {
      directories = [ ".thunderbird" ];
      cache.directories = [ ".cache/thunderbird" ];
    };
  };
}
