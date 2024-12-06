{ pkgs, ... }:

{

  programs.helix = {
    extraPackages = [ pkgs.tinymist ];
    languages = {
      language-server.tinymist = {
        command = "tinymist";
        config = {
          capabilities.hoverProvider = false;
          exportPdf = "onType";
          outputPath = "$root/$name";
          typstExtraArgs = [ "src.typ" ];
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
