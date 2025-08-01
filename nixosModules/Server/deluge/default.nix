{
  config,
  lib,
  meta,
  ...
}:

{
  options.custom = {
    deluge.enable = lib.mkEnableOption "enable deluge";
  };

  config = lib.mkIf config.custom.deluge.enable {

    services.deluge = {
      enable = true;
      web.enable = true;
      # authFile is broken for some reason, so these settings I define in deluge itself, and not in this nix file
      declarative = false;
      #      authFile = config.sops.secrets."mystuff/deluge".path;
      #      config = {
      #        allow_remote = true;
      #        pre_allocate_storage = true;
      #        max_upload_speed = 128.0;
      #        # need to make directory in "/var/lib/deluge" imperativly
      #        move_completed = true;
      #        move_completed_path = "${config.services.deluge.dataDir}/completed";
      #        copy_torrent_file = true;
      #        torrentfiles_location = "${config.services.deluge.dataDir}/torrent-files";
      #      };
    };
    networking.firewall.interfaces."zt+".allowedTCPPorts = [ 8112 ]; # Only allow ZeroTier
  };
}
