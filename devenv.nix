{ ... }:

{

  # https://devenv.sh/packages/
  # packages = [ pkgs.git ];

  # https://devenv.sh/languages/
  # Takes too much space
  # languages.nix.enable = true;

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks = {
    nixfmt-rfc-style.enable = true;
  };
}
