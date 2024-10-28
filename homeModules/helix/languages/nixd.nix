{ pkgs, ... }:

{

  programs.helix = {
    extraPackages = [ pkgs.nixd ];
    languages = {
      language-server.nixd = {
        command = "nixd";
      };
      # shout out to Zeth for adopting nixd to helix
      language = [
        {
          name = "nix";
          scope = "source.nix";
          injection-regex = "nix";
          file-types = [ "nix" ];
          comment-token = "#";
          indent = {
            tab-width = 2;
            unit = "  ";
          };
          language-servers = [ "nixd" ];
        }
      ];
    };
  };
}
