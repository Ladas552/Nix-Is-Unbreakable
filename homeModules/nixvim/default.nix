{
  lib,
  config,
  inputs,
  ...
}:
{
  options.customhm = {
    nixvim.enable = lib.mkEnableOption "enable nixvim";
  };

  imports = [
    # ./nvim/neorg.nix
    # ./nvim/option.nix
    # ./nvim/keymaps.nix
    # ./nvim/plugins.nix
    # ./nvim/colorscheme.nix
    inputs.nixvim.homeManagerModules.nixvim
  ];
  config = lib.mkIf config.customhm.nixvim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      plugins = {
        treesitter = {
          enable = true;
        };
        neorg = {
          enable = true;
          modules = {
            "core.defaults" = {
              __empty = null;
            };
            "core.dirman" = {
              config = {
                workspaces = {
                  general = "~/Norg";
                };
              };
            };
            "core.esupports.metagen" = {
              config = {
                timezone = "implicit-local";
                type = "empty";
                undojoin_updates = "false";
              };
            };
            "core.concealer" = {
              config = {
                __empty = null;
              };
            };
              "core.journal" = {
                config = {
                  workspace = "general";
                  journal_folder = "/./";
                };
              };
              "core.tangle" = {
                config = {
                  report_on_empty = false;
                  tangle_on_write = true;
                };
              };
            };
          };
        };
      };
      home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        SUDO_EDITOR = "nvim";
      };
    };
  }
