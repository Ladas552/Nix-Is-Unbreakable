{
  lib,
  config,
  pkgs,
  ...
}:

{

  options.customhm.shell = {
    nushell.enable = lib.mkEnableOption "enable nushell";
  };
  config = lib.mkIf config.customhm.shell.nushell.enable {
    programs.nushell = {
      enable = true;
      settings = {
        buffer_editor = "nvim";
        show_banner = false;
        render_right_prompt_on_last_line = true;
        float_precision = 2;
        table = {
          mode = "markdown";
        };
      };
      envFile.text = # nu
        ''
          $env.PROMPT_COMMAND_RIGHT = ""
        '';
    };
  };
}
