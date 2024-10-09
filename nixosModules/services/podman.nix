{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.custom = with lib; {
    distrobox.enable = mkEnableOption "enable distrobox";
    podman.enable = mkEnableOption "enable podman" // {
      default = config.custom.distrobox.enable;
    };
  };

  config = lib.mkIf (config.custom.podman.enable || config.custom.distrobox.enable) {
    environment.systemPackages = lib.mkIf config.custom.distrobox.enable [ pkgs.distrobox ];

    virtualisation = {
      podman = {
        enable = true;
        # create a `docker` alias for podman, to use it as a drop-in replacement
        dockerCompat = true;
        # required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  };
}
