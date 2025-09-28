{ lib, ... }:
# note: this file exists just to define options for home-manager,
# I don't use home-manager impermanence module
{
  options.customhm = {
    imp = {
      home = {
        directories = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Directories to persist in home directory";
        };
        files = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [ ];
          description = "Files to persist in home directory";
        };
        cache = {
          directories = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "Directories to persist, but not to snapshot";
          };
          files = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
            description = "Files to persist, but not to snapshot";
          };
        };
      };
    };
  };
}
