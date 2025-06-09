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
in
{
  vim = {
    treesitter.grammars = [
      norg
      treesitter-norg-meta
    ];
    notes.neorg = {
      enable = true;
      treesitter = {
        enable = true;
        norgPackage = norg;
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
