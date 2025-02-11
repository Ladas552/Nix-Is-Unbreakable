{ pkgs, ... }:

{

  programs.helix = {
    extraPackages = [
      pkgs.stylua
      pkgs.lua-language-server
    ];
    languages = {
      language-server.lua-language-server = {
        diagnostics = {
          globals = [
            "_G"
            "vim"
          ];
        };
      };
    };
  };
}
