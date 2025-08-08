{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom = {
    qbittorrent.enable = lib.mkEnableOption "enable qbittorrent";
  };

  config = lib.mkIf config.custom.qbittorrent.enable {
    # module
    services.qbittorrent = {
      enable = true;
      webuiPort = 8081;
      torrentingPort = 53243;
      serverConfig = {
        Preferences = {
          WebUI = {
            AlternativeUIEnabled = true;
            RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";
            Username = "admin";
            # generated with:
            # nix run 'git+https://codeberg.org/feathecutie/qbittorrent_password' -- -p password
            Password_PBKDF2 = "QQ1LEvyRba5oZavWfTJXkA==:sd8pTQ0S8MNpqt0AJfsiv0ja0+sTFukpHVAv0D4PzDuNVP62zyNW5uXpbekmp3tgbT0xBBGvK6c/B0kLt3++eQ==";
            AuthSubnetWhitelist = "${config.custom.homelab.ip}";
            AuthSubnetWhitelistEnabled = true;
            LocalHostAuth = false;
          };
          Downloads.SavePath = "/srv/media/Downloads";
          Connection.GlobalUPLimit = 200;
        };
        BitTorrent.Session = {
          GlobalMaxRatio = 2;
          GlobalUPSpeedLimit = 200;
          MaxActiveDownloads = 1;
          MaxActiveTorrents = 4;
          UseCategoryPathsInManualMode = true;
          DisableAutoTMMByDefault = false;
        };

      };
      extraArgs = [
        "--confirm-legal-notice"
      ];
    };
    users.users."qbittorrent".extraGroups = [ "media" ];

    networking.firewall.allowedTCPPorts = [
      53243
    ];
    networking.firewall.interfaces.ztcfwrb2q6.allowedTCPPorts = lib.mkIf config.custom.zerotier.enable [
      8081
    ]; # Only allow ZeroTier
    networking.firewall.interfaces.tailscale0.allowedTCPPorts =
      lib.mkIf config.custom.tailscale.enable
        [ 8081 ]; # Only allow Tailscale

    #  IF GPT is right, it allows for torrents to download in readable state, But I am not sure, and I will check it later. But it just works now. 8th of August 2025
    systemd.services.qbittorrent.serviceConfig.UMask = "002"; # Sets UMask for the qbittorrent service

  };
}
