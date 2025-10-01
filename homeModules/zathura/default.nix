{ lib, config, ... }:

{

  options.customhm = {
    zathura.enable = lib.mkEnableOption "enable zathura";
  };
  config = lib.mkIf config.customhm.zathura.enable {
    programs.zathura = {
      enable = true;
      mappings = {
        "i"= "recolor";
      };
    };

    # persist for Impermanence
    customhm.imp.home.cache.directories = [".local/share/zathura"];
  };
}
