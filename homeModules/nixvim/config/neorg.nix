{
  pkgs,
  lib,
  inputs,
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
  # Neorg Plugins
  neorg-query = pkgs.vimUtils.buildVimPlugin {
    name = "neorg-query";
    src = pkgs.fetchFromGitHub {
      owner = "benlubas";
      repo = "neorg-query";
      rev = "36729d83695226e0ddbbe6503583d36b0433c93a";
      sha256 = "1dahz32qprj7xa3m0wz6bnkgzdb5mi9rly6m6ccw5d9z0qa6ghm5";
    };
  };
  neorg-interim-ls = pkgs.vimUtils.buildVimPlugin {
    name = "neorg-interim-ls";
    src = pkgs.fetchFromGitHub {
      owner = "benlubas";
      repo = "neorg-interim-ls";
      rev = "5aec3bb82a774dce797e5796d3be906aa3361650";
      sha256 = "11ldv4cqaxlgamsvgay8b3dvrf15sb36fihnsli0f53nnv6l65cg";
    };
  };
in
{
  options.customhm = {
    nixvim.plugins.Neorg = lib.mkEnableOption "Neorg from nixpkgs setup";
  };

  config = lib.mkIf (config.customhm.nixvim.enable && config.customhm.nixvim.plugins.Neorg) {
    home.packages =
      [ ]
      ++ lib.optionals (meta.system == "x86_64-linux") [ inputs.norgolith.packages.x86_64-linux.default ];
    programs.nixvim = {
      extraPlugins = [
        treesitter-norg-meta
        # neorg-query
        # neorg-interim-ls
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
          settings.load = {
            # Don't seem to work on Nixvim
            # Extra modules
            # "external.query" = {
            #   __empty = null;
            #   index_on_launch = true;
            #   update_on_change = true;
            # };
            # "external.interim-ls" = {
            #   __empty = null;
            #   config = {
            #     completion_provider = {
            #       categories = true;
            #     };
            #   };
            # };
            # Core
            "core.defaults" = {
              __empty = null;
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
          };
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
