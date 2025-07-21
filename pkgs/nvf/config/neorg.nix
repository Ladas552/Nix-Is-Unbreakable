{
  pkgs,
  lib,
  inputs,
  config,
  meta,
  ...
}:
{
  vim = {
    notes.neorg = {
      enable = true;
      treesitter = {
        enable = true;
      };
      setupOpts.load = {
        # Core
        "core.defaults" = {
          enable = true;
          config.disable = lib.mkIf (!lib.isString meta.norg) [
            "core.dirman"
            "core.esupports.metagen"
            "core.journal"
            "core.summary"
            "core.integrations.telescope"
          ];
        };
        "core.concealer" = {
          config.icon_preset = "diamond";
        };
        "core.esupports.metagen" = lib.mkIf (lib.isString meta.norg) {
          config = {
            timezone = "implicit-local";
            type = "empty";
            undojoin_updates = false;
          };
        };
        "core.tangle" = {
          config = {
            report_on_empty = true;
            tangle_on_write = false;
          };
        };
        # "core.completion" = {
        #   config = {
        #     engine = {
        #       module_name = "external.lsp-completion";
        #     };
        #   };
        # };
        "core.keybinds" = lib.mkIf (lib.isString meta.norg) {
          config = {
            default_keybinds = true;
            neorg_leader = "<Leader><Leader>";
          };
        };
        "core.journal" = lib.mkIf (lib.isString meta.norg) {
          config = {
            workspace = "journal";
            journal_folder = "/./";
          };
        };
        "core.dirman" = lib.mkIf (lib.isString meta.norg) {
          config = {
            workspaces = {
              general = "${meta.norg}";
              life = "${meta.norg}/Life";
              work = "${meta.norg}/Study";
              journal = "${meta.norg}/Journal";
              archive = "${meta.norg}/Archive";
            };
            default_workspace = "general";
          };
        };
        "core.summary" = lib.mkIf (lib.isString meta.norg) { };
        "core.integrations.telescope" = lib.mkIf (lib.isString meta.norg) { };
      };
    };
    luaConfigRC.basic = # lua
      ''
        vim.g.maplocalleader = "  "
        vim.wo.foldlevel = 99
        vim.wo.conceallevel = 2
      '';
    extraPlugins."neorg-telescope".package = "neorg-telescope";
  };
}
