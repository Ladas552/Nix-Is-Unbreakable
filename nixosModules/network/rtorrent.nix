{ config, lib, ... }:

{
  options.custom = {
    rtorrent.enable = lib.mkEnableOption "enable rtorrent";
  };

  config = lib.mkIf config.custom.rtorrent.enable {
    services.rtorrent = {
      enable = true;
      downloadDir = "~/Downloads/Browser_Saves/torrents";
      openFirewall = true;
    };
    networking.firewall.allowedTCPPorts = [ 50000 ];
  };
}
