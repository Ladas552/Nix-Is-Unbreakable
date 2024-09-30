{ lib, config, ... }:

{

  options.customhm = {
    yazi.enable = lib.mkEnableOption "enable yazi";
  };
  config = lib.mkIf config.customhm.yazi.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      shellWrapperName = "mc";
      settings = {
        manager = {
          sort_by = "natural";
          sort_dir_first = true;
          linemode = "size";
          show_symlink = true;
          scrolloff = 8;
        };
        preview = {
          cache_dir = "${config.xdg.cacheHome}/yazi";
        };
        opener = {
          text = [
            {
              run = ''nvim "$@"'';
              desc = "Edit text";
              for = "unix";
              block = true;
            }
          ];
          video = [
            {
              run = ''mpv "$@"'';
              desc = "Play video";
              for = "unix";
              block = true;
            }
          ];
        };
      };
    };
  };
}