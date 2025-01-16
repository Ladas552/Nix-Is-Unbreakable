{
  pkgs,
  lib,
  config,
  meta,
  ...
}:
let
  #Norg meta treesitter-parser

  treesitter-norg-meta = pkgs.tree-sitter.buildGrammar {
    language = "norg-meta";
    version = "0.1.0";

    src = pkgs.fetchFromGitHub {
      owner = "nvim-neorg";
      repo = "tree-sitter-norg-meta";
      rev = "refs/tags/v0.1.0";
      hash = "sha256-8qSdwHlfnjFuQF4zNdLtU2/tzDRhDZbo9K54Xxgn5+8=";
    };

    fixupPhase = ''
      mkdir -p $out/queries/norg-meta
      mv $out/queries/*.scm $out/queries/norg-meta/
    '';

    meta.homepage = "https://github.com/nvim-neorg/tree-sitter-norg-meta";
  };
in
{
  options.customhm = {
    nixvim.plugins.Neorg = lib.mkEnableOption "Neorg from nixpkgs setup";
  };

  config = lib.mkIf (config.customhm.nixvim.enable && config.customhm.nixvim.plugins.Neorg) {
    programs.nixvim = {
      extraPlugins = [
        treesitter-norg-meta
      ];
      plugins = {
        treesitter = {
          grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
            treesitter-norg-meta
            norg
          ];
        };
        # Neorg
        neorg = {
          enable = true;
          telescopeIntegration.enable = true;
          settings.load =
            {
              "core.defaults" = {
                __empty = null;
              };
              "core.esupports.metagen" = {
                config = {
                  timezone = "implicit-local";
                  type = "empty";
                  undojoin_updates = "false";
                };
              };
              "core.tangle" = {
                config = {
                  report_on_empty = true;
                  tangle_on_write = false;
                };
              };
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
                  };
                  default_workspace = "general";
                };
              };
              "core.concealer" = {
                config = {
                  icon_preset = "diamond";
                };
              };
              "core.summary" = {
                __empty = null;
              };
              "core.integrations.telescope" = {
                __empty = null;
              };
            }
            // lib.listToAttrs (
              lib.optionals (!meta.isTermux) [
                {
                  name = "core.integrations.image";
                  value = {
                    __empty = null;
                  };
                }
              ]
            );
        };
      };
      extraConfigLua = # lua
        ''
          vim.g.maplocalleader = "  "
          vim.wo.foldlevel = 99
          vim.wo.conceallevel = 2
        '';
    };
  };
}
