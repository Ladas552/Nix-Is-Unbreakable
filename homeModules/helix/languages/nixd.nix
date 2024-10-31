{ pkgs, ... }:

{

  programs.helix = {
    extraPackages = [
      pkgs.nixd
      pkgs.nixfmt-rfc-style
    ];
    languages = {
      language-server.nixd = {
        command = "nixd";
        args = [ "--inlay-hints=true" ];
        config = {
          formatting.command = [ "nixfmt" ];
        };
      };
      # shout out to Zeth for adopting nixd to helix
      language = [
        {
          name = "nix";
          scope = "source.nix";
          injection-regex = "nix";
          formatter = {
            command = "nixfmt";
          };
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
