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
  src = pkgs.fetchFromGitHub {
    owner = "benlubas";
    repo = "neorg-query";
    rev = "3b1e0cf87725a5d341cf55e22e1193f57a8f6ddd";
    hash = "sha256-AWB2p9dizeVq5ieLJHU1eL0TjoNIEUwKazVNnFNwO9s=";
  };
  lib-neorg_query = pkgs.rustPlatform.buildRustPackage {
    inherit src;
    name = "neorg_query";

    useFetchCargoVendor = true;
    cargoHash = "sha256-m/QhtE6e2wmTRBQ8xrWfgsmvDaaR1s9z/BLoFgFz/Do=";

    nativeBuildInputs = [ pkgs.gitMinimal ];

  };
  neorg-query = pkgs.vimUtils.buildVimPlugin {
    name = "neorg-query";
    inherit src;
    preInstall =
      let
        ext = pkgs.stdenv.hostPlatform.extensions.sharedLibrary;
      in
      ''
        mkdir -p $out/lua/neorg_query
        ln -s ${lib-neorg_query}/lib/libneorg_query${ext} $out/lua/
      '';
    nvimSkipModules = [
      # skip checks
      "neorg.modules.external.query.module"
      "neorg_query.formatter"
      "neorg_query.api"
    ];
  };
  neorg-interim-ls = pkgs.vimUtils.buildVimPlugin {
    name = "neorg-interim-ls";
    src = pkgs.fetchFromGitHub {
      owner = "benlubas";
      repo = "neorg-interim-ls";
      rev = "348cd121d8b872248e9b0e48e3611c54dfad83f0";
      sha256 = "1vszvmsy27n68ivi6bmk1hifi00dg33mc9iz66nv2gfmwcfwbsfz";
    };
    nvimSkipModules = [
      # skip checks
      "neorg.modules.external.lsp-completion.module"
      "neorg.modules.external.interim-ls.module"
      "neorg.modules.external.refactor.module"
    ];
  };
  neorg-conceal-wrap = pkgs.vimUtils.buildVimPlugin {
    name = "neorg-conceal-wrap";
    src = pkgs.fetchFromGitHub {
      owner = "benlubas";
      repo = "neorg-conceal-wrap";
      rev = "e08b06042b175355496d3b5b033658021b90cd82";
      sha256 = "1jy40wrmv7fdglglzcaasayh9hn8k99ccz35ssjgmmxnk76n5gnz";
    };
    nvimSkipModules = [
      # skip checks
      "neorg.modules.external.conceal-wrap.module"
    ];
  };
in
{
  extraPlugins = [
    neorg-conceal-wrap
    neorg-interim-ls
    neorg-query
  ];
  performance.combinePlugins.pathsToLink = [ "/lib" ];
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
        # Extra modules
        "external.query" = {
          config = {
            index_on_launch = true;
            update_on_change = true;
          };
        };
        "external.interim-ls" = {
          config = {
            completion_provider = {
              categories = true;
            };
          };
        };
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
        "core.completion" = {
          config = {
            engine = {
              module_name = "external.lsp-completion";
            };
          };
        };
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
