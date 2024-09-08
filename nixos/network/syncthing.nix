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
            # Here is an explanation to sops templates
            # https://www.reddit.com/r/NixOS/comments/1draqf1/i_cannot_get_sopsnix_to_import_my_secrets_properly/
            id = config.sops.templates."phone".content;
          };
          "Tab 12" = {
            id = config.sops.templates."tablet".content;
          };
        };
        folders = {
          "Norg" = {
            versioning = {
              type = "trashcan";
              params.cleanoutDays = "7";
            };
            path = "~/Documents/Norg";
            id = config.sops.templates."Norg".content;
            devices = [
              "Tab 12"
              "RMX3081"
            ];
          };
          "Share" = {
            path = "~/Share";
            id = config.sops.templates."Share".content;
            devices = [
              "Tab 12"
              "RMX3081"
            ];
          };
          "keepass" = {
            versioning = {
              type = "trashcan";
              params.cleanoutDays = "7";
            };
            path = "~/Documents/Keepass";
            id = config.sops.templates."keepass".content;
            devices = [
              "Tab 12"
              "RMX3081"
            ];
          };
        };
      };
    };
  };
}
