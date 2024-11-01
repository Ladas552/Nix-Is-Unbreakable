{ pkgs, ... }:

{

  programs.helix = {
    extraPackages = [ pkgs.nixd ];
    languages = {
      language-server.nixd = {
        command = "nixd";
        args = [ "--inlay-hints=true" ];
      };
      # shout out to Zeth for adopting nixd to helix
      language = [
        {
          name = "nix";
          scope = "source.nix";
          injection-regex = "nix";
          # Disables auto-save because of a bug
          # auto-format = true;
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
