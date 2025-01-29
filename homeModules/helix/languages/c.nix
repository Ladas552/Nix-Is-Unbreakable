{ pkgs, ... }:

{

  programs.helix = {
    extraPackages = [ pkgs.clang-tools ];
    languages = {
      language-server.clangd = {
        command = "clangd";
      };
    };
  };
}
