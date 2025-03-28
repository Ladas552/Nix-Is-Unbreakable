{ pkgs, inputs, ... }:

{
  # I don't use it because it only works with syntax like
  # color = "#asdad", and now with any other, so it will not be imported, but here is a link if you want to add it
  # inputs.uwu-colors.url = "github:q60/uwu_colors";
  programs.helix = {
    extraPackages = [
      inputs.uwu-colors.packages.${pkgs.system}.default
    ];
    languages = {
      language-server.uwu_colors = {
        command = "uwu_colors";
      };
      language = [
        {
          name = "css";
          scope = "source.css";
          injection-regex = "css";
          file-types = [
            "css"
            "nix"
          ];
          language-servers = [ "uwu_colors" ];
        }
      ];
    };
  };
}
