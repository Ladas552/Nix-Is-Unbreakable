{ ... }:
{
  performance.combinePlugins.standalonePlugins = [ "typst-preview.nvim" ];
  plugins.typst-preview = {
    enable = true;
    settings = {
      follow_cursor = true;
      open_cmd = "chromium %s";
    };
  };
}
