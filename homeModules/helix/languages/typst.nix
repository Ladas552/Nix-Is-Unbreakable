{ pkgs, ... }:

{

  programs.helix = {
    extraPackages = [
      pkgs.tinymist
      pkgs.typstyle
    ];
    languages = {
      language-server.tinymist = {
        command = "tinymist";
        config = {
          capabilities.hoverProvider = false;
          exportPdf = "onType";
          outputPath = "$root/$name";
          typstExtraArgs = [ "src.typ" ];
          fontPaths = [ "./fonts" ];
          formatterMode = "typstyle";
        };
      };
      language = [
        {
          name = "typst";
          scope = "source.typ";
          injection-regex = "typ";
          file-types = [ "typ" ];
          comment-token = "//";
          language-servers = [ "tinymist" ];
        }
      ];
    };
  };
}
