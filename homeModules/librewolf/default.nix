{
  pkgs,
  lib,
  config,
  meta,
  ...
}:

{

  options.customhm = {
    librewolf.enable = lib.mkEnableOption "enable librewolf";
  };
  config = lib.mkIf config.customhm.librewolf.enable {
    programs.librewolf = {
      enable = true;
      nativeMessagingHosts = [
        pkgs.keepassxc
        pkgs.ff2mpv
      ];
      policies = {
        # stolen from @heisfer
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableFeedbackCommands = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxStudies = true;
        DisableFormHistory = true;
        DisablePocket = true;
        DisableSetDesktopBackground = true;
        DisableTelemetry = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;
        SearchSuggestEnable = false;
        UserMessaging = {
          WhatsNew = false;
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          UrlbarInterventions = false;
          SkipOnboarding = true;
          MoreFromMozilla = false;
          FirefoxLabs = false;
          Locked = true;
        };
        FirefoxSuggest = {
          WebSuggestions = false;
          SponsoredSuggestions = false;
          ImproveSuggest = false;
          Locked = true;
        };
      };
      profiles."${meta.user}" = {
        isDefault = true;
        bookmarks = { };
        containersForce = true;
        containers = { };
        settings = { };
        search = {
          default = "ddg";
          force = true;
          order = [
            "ddg"
            "nix-packages"
            "nixos-options"
            "nixos-wiki"
          ];
          engines = {
            nix-packages = {
              name = "Nix Packages";
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];

              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };
            nixos-options = {
              name = "NixOS Options";
              urls = [ { template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}"; } ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              defineAliases = [ "@no" ];
            };

            nixos-wiki = {
              name = "NixOS Wiki";
              urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
              iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
              definedAliases = [ "@nw" ];
            };
            searxng.metaData.hidden = true;
          };
        };
      };
    };
  };
}
