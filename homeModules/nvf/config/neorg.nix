{
  pkgs,
  lib,
  inputs,
  config,
  meta,
  ...
}:
{
  options.customhm = {
    nvf.plugins.Neorg = lib.mkEnableOption "Neorg from nixpkgs setup";
  };

  config = lib.mkIf (config.customhm.nvf.enable && config.customhm.nvf.plugins.Neorg) {
    programs.nvf.settings.vim = {
      notes.neorg = {
        enable = true;
        treesitter.enable = true;
        setupOpts.load = {
          # Core
          "core.defaults" = {
            enable = true;
          };
          "core.esupports.metagen" = {
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
          "core.keybinds" = {
            config = {
              default_keybinds = true;
              neorg_leader = "<Leader><Leader>";
            };
          };
          "core.journal" = {
            config = {
              workspace = "journal";
              journal_folder = "/./";
            };
          };
          "core.dirman" = {
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
          "core.concealer" = {
            config.icon_preset = "diamond";
          };
          "core.summary" = {};
          "core.integrations.telescope" = {};
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
  };
}
