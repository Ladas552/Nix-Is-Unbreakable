{
  config,
  lib,
  pkgs,
  meta,
  ...
}:

{
  options.custom = {
    incus.enable = lib.mkEnableOption "enable incus";
  };
  # Incus is really powerfull, with cool WebUI for both Containers and VM
  # But I can't install packages in containers for some reaosn
  # And my nvidia GPU passtrouh doesn't work
  # So it will stay here, not used

  config = lib.mkIf config.custom.incus.enable {
    # outputs error without this
    networking.nftables.enable = true;
    # incus module
    # example command
    # incus create images:archlinux ArchLinux -c nvidia.runtime=true
    virtualisation.incus = {
      enable = true;
      agent.enable = true;
      ui.enable = true;
    };
    # Stolen from @saygo and @Michael-C-Buckley
    users.users.${meta.user}.extraGroups = [ "incus-admin" ];
    environment.systemPackages = [ pkgs.virtiofsd ];
    # Incus is bested used with these modules available
    boot.kernelModules = [
      "virtiofs"
      "9p"
      "9pnet_virtio"
    ];
    networking.firewall.interfaces.ztcfwrb2q6.allowedTCPPorts = [ 8443 ]; # Only allow ZeroTier

    # persist for Impermanence
    custom.imp.root.cache.directories = [ "/var/lib/incus" ];
  };
}
