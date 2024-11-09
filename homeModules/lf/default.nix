{
  lib,
  config,
  ...
}:

{

  options.customhm = {
    lf.enable = lib.mkEnableOption "enable lf";
  };
  config = lib.mkIf config.customhm.lf.enable {
    programs.lf = {
      enable = true;
      settings = {
        period = 1;
        dircounts = true;
        info = "size";
        dupfilefmt = "%f_";
        findlen = 0;
        # icons = true;
        incsearch = true;
      };
    };
  };
}
