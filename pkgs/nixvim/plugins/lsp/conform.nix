{ ... }:
{
  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save = {
        timeout_ms = 500;
      };
      formatters_by_ft = {
        elixir = [ "mix" ];
      };
    };
  };
}
