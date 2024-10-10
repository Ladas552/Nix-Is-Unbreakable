{ pkgs, ... }:

{

  # https://devenv.sh/packages/
  packages = [ pkgs.git ];

  # https://devenv.sh/languages/
  languages.nix.enable = true;

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks = {
    shellcheck.enable = true;
    nixfmt-rfc-style = {
      enable = true;
      package = pkgs.nixfmt-rfc-style;
    };
    deadnix.enable = true;
  };
}
