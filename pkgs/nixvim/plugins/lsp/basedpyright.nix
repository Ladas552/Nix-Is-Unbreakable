{ lib, pkgs, ... }:
{
  plugins.lsp.servers.basedpyright.enable = true;
  plugins.conform-nvim.settings = {
    python = [
      "ruff_fix"
      "ruff_format"
    ];
    formatters_by_ft.formatters = {
      ruff_format.command = lib.getExe' pkgs.ruff "ruff";
      ruff_fix.command = lib.getExe' pkgs.ruff "ruff";
    };
  };
}
