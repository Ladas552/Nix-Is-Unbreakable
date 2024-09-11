{ config, lib, pkgs, ...}:

{
  options.custom = {
    syncthing.enable = lib.mkEnableOption "enable syncthing";
  };

  config = lib.mkIf config.custom.syncthing.enable {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      guiAddress = "127.0.0.1:8888";
      settings = {
        options.urAccepted = -1;
        devices = {
          "RMX3081" = {
            id = "$(cat ${config.sops.secrets."mystuff/syncthing/devices/phone".path})";
          };
          "Tab 12" = {
            id = "cat ${config.sops.secrets."mystuff/syncthing/devices/tablet".path}";
          };
        };
      };
      #   folders = {
      #     "Norg" = {
      #       versioning = {
      #         type = "trashcan";
      #         params.cleanoutDays = "7";
      #       };
      #       path = "~/Documents/Norg";
      #       id = "cat ${config.sops.secrets."mystuff/syncthing/folders/Norg".path}";
      #       devices = [
      #         "Tab 12"
      #         "RMX3081"
      #       ];
      #     };
      #     "Share" = {
      #       path = "~/Share";
      #       id = "cat ${config.sops.secrets."mystuff/syncthing/folders/Share".path}";
      #       devices = [
      #         "Tab 12"
      #         "RMX3081"
      #       ];
      #     };
      #     "keepass" = {
      #       versioning = {
      #         type = "trashcan";
      #         params.cleanoutDays = "7";
      #       };
      #       path = "~/Documents/Keepass";
      #       id = "cat ${config.sops.secrets."mystuff/syncthing/folders/keepass".path}";
      #       devices = [
      #         "Tab 12"
      #         "RMX3081"
      #       ];
      #     };
      #   };
      # };
    };
  };
}
