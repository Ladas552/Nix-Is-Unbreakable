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
        folders = {
          "Norg" = {
            versioning = {
              type = "trashcan";
              params.cleanoutDays = "7";
            };
            path = "~/Documents/Norg";
            id = "v7kgm-y6wwz";
          };
          "Share" = {
            path = "~/Share";
            id = "ytud2-kxxjf";
          };
          "keepass" = {
            versioning = {
              type = "trashcan";
              params.cleanoutDays = "7";
            };
            path = "~/Documents/Keepass";
            id = "isc6x-muciy";
          };
        };
      };
    };
  };
}
