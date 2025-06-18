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

  norg = pkgs.tree-sitter.buildGrammar {
    language = "norg";
    version = "0.0.0+rev=d89d95a";

    src = pkgs.fetchFromGitHub {
      owner = "nvim-neorg";
      repo = "tree-sitter-norg";
      rev = "d89d95af13d409f30a6c7676387bde311ec4a2c8";
      hash = "sha256-z3h5qMuNKnpQgV62xZ02F5vWEq4VEnm5lxwEnIFu+Rw=";
    };

    meta.homepage = "https://github.com/nvim-neorg/tree-sitter-norg";

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
  plugins = {
    treesitter = {
      grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
        treesitter-norg-meta
        norg
      ];
    };
    # Neorg
    neorg = {
      enable = true;
      telescopeIntegration.enable = config.plugins.telescope.enable;
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
        "core.concealer" = {
          config = {
            icon_preset = "diamond";
          };
        };
        "core.summary" = lib.mkIf (lib.isString meta.norg) {
          __empty = null;
        };
        "core.integrations.telescope" =
          lib.mkIf (lib.isString meta.norg && config.plugins.telescope.enable)
            {
              __empty = null;
            };
      };
    };
  };
  globals = {
    maplocalleader = "  ";
  };
  opts = {
    foldlevel = 99;
    conceallevel = 2;
  };
}
