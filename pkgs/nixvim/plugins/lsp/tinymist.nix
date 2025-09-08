{
  lib,
  pkgs,
  ...
}:
{
  plugins.lsp.servers.tinymist = {
    enable = true;
    settings = {
      exportPdf = "onType";
      outputPath = "$root/$name";
      fontPaths = [ "./fonts" ];
      formatterMode = "typstyle";
    };
  };
  plugins.conform-nvim.settings = {
    formatters_by_ft.typst = [ "typstyle" ];
    formatters.typstyle.command = lib.getExe' pkgs.typstyle "typstyle";
  };
}
