{
  pkgs,
  lib,
  config,
  meta,
  ...
}:
{

  config = lib.mkIf meta.isTermux {

    extraPlugins = [
      pkgs.vimPlugins."gitsigns-nvim"
      pkgs.vimPlugins.img-clip-nvim
    ];
    plugins = {

      friendly-snippets.enable = true;
      #UI
      which-key = {
        enable = true;
      };

      barbar = {
        enable = true;
        settings = {
          animation = false;
          auto_hide = 1;
        };
      };

      web-devicons = {
        enable = true;
      };

      colorizer.enable = true;

      neogit = {
        enable = true;
      };

      telescope = {
        enable = false;
        # settings.defaults = {
        #   path_display = "truncate";
        # };
      };

      snacks = {
        enable = true;
        settings = {
          bigfile.enabled = true;
          image.enabled = false;
          picker = {
            enabled = true;
          };
        };
      };

      dashboard = {
        enable = true;
        settings = {
          theme = "doom";
          shortcut_type = "number";
          config = {
            header = [
              " "
              "Good living ain't ya?"
              " "
            ];
            center =
              [ ]
              ++ lib.optionals config.plugins.telescope.enable [
                {
                  action = "Telescope oldfiles";
                  desc = " Recent Files";
                  icon = "󰥔 ";
                  key = "R";
                }
                {
                  action = "Telescope find_files";
                  desc = " Find Files";
                  icon = " ";
                  key = "F";
                }
              ]

              ++ lib.optionals (config.plugins.snacks.settings.picker.enabled && config.plugins.snacks.enable) [
                {
                  action = "lua Snacks.picker.recent()";
                  desc = " Recent Files";
                  icon = "󰥔 ";
                  key = "R";
                }
                {
                  action = "lua Snacks.picker.projects()";
                  desc = " List Projects";
                  icon = " ";
                  key = "F";
                }
              ]
              ++ [
                {
                  action = "ene | startinsert";
                  desc = " New File";
                  icon = " ";
                  key = "N";
                }
              ]
              ++ lib.optionals config.plugins.neorg.enable [
                {
                  action = "Neorg workspace life";
                  desc = " Neorg Life";
                  icon = "󰠮 ";
                  key = "E";
                }
                {
                  action = "Neorg workspace work";
                  desc = " Neorg Work";
                  icon = " ";
                  key = "W";
                }
                {
                  action = "Neorg journal today";
                  desc = " Neorg Journal";
                  icon = "󰛓 ";
                  key = "J";
                }
              ]
              ++ [
                {
                  action = "qa";
                  desc = " Quit";
                  icon = "󰩈 ";
                  key = "Q";
                }
              ];
            footer = [ "Just Do Something Already!" ];
          };
        };
      };
      # cmp
      blink-cmp = {
        enable = true;
        settings = {
          keymap = {
            preset = "enter";
            "<Tab>" = [
              "select_next"
              "fallback"
            ];
            "<S-Tab>" = [
              "select_prev"
              "accept"
              "fallback"
            ];
          };
          signature = {
            enabled = true;
            window.border = "rounded";
          };
          completion = {
            documentation = {
              auto_show = true;
              auto_show_delay_ms = 1000;
              window.border = "rounded";
            };
            list.selection = {
              preselect = false;
              auto_insert = true;
            };
            menu = {
              border = "single";
              draw.columns = {
                # idk how to set it up
                # { "label",     "label_description", gap = 1 },
                # { "kind_icon", "kind" },
              };
            };
            ghost_text.enabled = true;
            keyword.range = "prefix"; # can also be `full`
          };
          sources = {
            providers = {
              buffer.score_offset = -7;
            };
            default = [
              "path"
              "snippets"
              "buffer"
            ];
          };
        };
      };
      luasnip.enable = true;

      oil = {
        enable = true;
        settings = {
          view_options = {
            show_hidden = true;
          };
        };
      };

      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;
        };
      };

      treesitter = {
        enable = true;
        folding = true;
        nixvimInjections = true;
        grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
          lua
          rust
          bash
          fish
        ];
        settings = {
          indent.enable = true;
          highlight.enable = true;
        };
      };

      auto-save = {
        enable = true;
      };
    };
  };
}
