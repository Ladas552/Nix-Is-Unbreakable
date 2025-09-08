{
  meta,
  lib,
  pkgs,
  ...
}:
{
  plugins.lsp.servers.nixd = {
    enable = true;
    # neovim trows  an error with semantic tokens
    cmd = [
      "nixd"
      "--semantic-tokens=false"
    ];
    # doesn't work btw
    settings = {
      nixpkgs.expr = "import <nixpkgs> { }";
      nixos.expr = "(builtins.getFlake ''${meta.self}'').nixosConfigurations.NixToks.options";
      home-manager.expr = "(builtins.getFlake ''${meta.self}'').nixosConfigurations.NixToks.options.home-manager.users.type.getSubOptions []";
    };
  };
  plugins.conform-nvim.settings = {
    formatters_by_ft.nix = [ "nixfmt" ];
    formatters.nixfmt.command = lib.getExe' pkgs.nixfmt "nixfmt";
  };
}
