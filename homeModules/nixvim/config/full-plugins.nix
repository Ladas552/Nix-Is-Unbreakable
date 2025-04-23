{
  pkgs,
  lib,
  config,
  meta,
  ...
}:
let

  typst-tools.nvim = pkgs.vimUtils.buildVimPlugin {
    name = "typst-tools.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "max397574";
      repo = "typst-tools.nvim";
      rev = "a16c20c6e5756164458f72faf4353b435376cb4f";
      sha256 = "0hppipi30p75i0rvhin6lphp2wvb3xpf7sr8x21zainx3d69pfby";
    };
  };
in
{

  options.customhm = {
    nixvim.plugins.NixToks = lib.mkEnableOption "neovim plugins for desktop";
  };

  config = lib.mkIf (config.customhm.nixvim.enable && config.customhm.nixvim.plugins.NixToks) {
    #formatters
    home.packages = with pkgs; [
      black
      stylua
      typstyle
      # typix web integration
      websocat
    ];

    programs.nixvim = {
      performance.combinePlugins.standalonePlugins = [
        "oil.nvim"
        "norg-meta-grammar"
        "typst-preview.nvim"
        "neorg"
      ];
      extraPlugins = [
        pkgs.vimPlugins.typst-preview-nvim
        pkgs.vimPlugins."gitsigns-nvim"
        pkgs.vimPlugins."lspkind-nvim"
        pkgs.vimPlugins.img-clip-nvim
        # Broke on latest NixVim
        # typst-tools.nvim

        # (pkgs.vimUtils.buildVimPlugin {
        #   name = "markview.nvim";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "OXY2DEV";
        #     repo = "markview.nvim";
        #     rev = "3adfe75139f755eace69277b7097d0376cb6068a";
        #     sha256 = "1g97w059fkcrncwxcbyqk4n1d3xl7cffm6l6faswsqhih63zrbcd";
        #     # nix run nixpkgs#nix-prefetch-git https://github.com/OXY2DEV/markview.nvim.git
        #   };
        # })
      ];
      plugins = {
        #LSP
        lsp = {
          enable = true;
          inlayHints = true;
          servers = {
            nixd = {
              enable = true;
              # neovim trows  an error with semantic tokens
              cmd = [
                "nixd"
                "--semantic-tokens=false"
              ];
              # doesn't work btw
              settings = {
                nixpkgs.expr = "import <nixpkgs> { }";
                nixos.expr = "(builtins.getFlake ''${meta.self}'').nixosConfigurations.NixToks.options";
                home-manager.expr = "(builtins.getFlake ''${meta.self}'').nixosConfigurations.NixToks.options.home-manager.users.type.getSubOptions []";
              };
            };
            tinymist = {
              enable = true;
              settings = {
                exportPdf = "onType";
                fontPaths = [ "./fonts" ];
                formatterMode = "typstyle";
              };
            };
            clangd = {
              enable = true;
            };
          };
          keymaps = {
            silent = true;
            diagnostic = {
              # Navigate in diagnostics
              "<leader>[" = "goto_prev";
              "<leader>]" = "goto_next";
            };
            lspBuf = {
              "<leader>ld" = "definition";
              "<C-LeftMouse>" = "definition";
              "<F2>" = "rename";
              "<leader>lD" = "implementation";
              "<leader>lc" = "code_action";
              K = "hover";
            };
          };
        };

        # lsp-lines.enable = true;
        friendly-snippets.enable = true;
        lint.enable = true;
        trim.enable = true;
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

        telescope = {
          enable = true;
          # settings.defaults = {
          #   path_display = "truncate";
          # };
        };

        dashboard = {
          enable = true;
          settings = {
            theme = "doom";
            shortcut_type = "number";
            config = {
              header = [
                "                                                                "
                "██╗      █████╗ ██████╗  █████╗ ███████╗███████╗███████╗██████╗ "
                "██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝╚════██╗"
                "██║     ███████║██║  ██║███████║███████╗███████╗███████╗ █████╔╝"
                "██║     ██╔══██║██║  ██║██╔══██║╚════██║╚════██║╚════██║██╔═══╝ "
                "███████╗██║  ██║██████╔╝██║  ██║███████║███████║███████║███████╗"
                "╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚══════╝"
                "                                                                "
              ];
              center = [
                {
                  action = "Telescope oldfiles";
                  desc = " Recent files";
                  icon = "󰥔 ";
                  key = "R";
                }
                {
                  action = "Telescope find_files";
                  desc = " Find files";
                  icon = " ";
                  key = "F";
                }
                {
                  action = "ene | startinsert";
                  desc = " New file";
                  icon = " ";
                  key = "N";
                }
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
                "lsp"
                "path"
                "snippets"
                "buffer"
              ];
            };
          };
        };
        luasnip.enable = true;

        #Workflow
        oil = {
          enable = true;
          settings = {
            delete_to_trash = true;
            view_options = {
              show_hidden = true;
            };
          };
        };
        # Installs neotest, which is broken
        # overseer = {
        #   enable = true;
        # };

        flash.enable = true;

        nvim-autopairs = {
          enable = true;
          settings = {
            check_ts = true;
          };
        };

        nix.enable = true;

        treesitter = {
          enable = true;
          folding = true;
          nixvimInjections = true;
          grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
            bash
            bibtex
            c
            cmake
            comment
            commonlisp
            cpp
            css
            csv
            diff
            dockerfile
            fish
            git_rebase
            gitcommit
            gitignore
            go
            html
            ini
            javascript
            json
            jsonc
            julia
            kdl
            kotlin
            lua
            luadoc
            make
            markdown
            markdown_inline
            nix
            python
            rasi
            requirements
            ron
            rust
            sxhkdrc
            todotxt
            toml
            typescript
            typst
            vim
            vimdoc
            xml
            yaml
            zathurarc
          ];
          settings = {
            indent.enable = true;
            highlight.enable = true;
            incremental_selection = {
              enable = true;
              keymaps = {
                init_selection = "<C-space>";
                node_incremental = "<C-space>";
                scope_incremental = false;
                node_decremental = "<bs>";
              };
            };
            ensure_installed = [
              "bash"
              "fish"
              "gitignore"
              "html"
              "latex"
              "lua"
              "make"
              "markdown"
              "markdown_inline"
              "kotlin"
              "nix"
              "python"
              "vim"
              "rust"
              "yaml"
              "zathurarc"
            ];
          };
        };

        # image = {
        #   enable = true;
        #   windowOverlapClearEnabled = true;
        #   extraOptions = {
        #     integrations.typst = {
        #       enabled = false;
        #     };
        #   };
        #   integrations.neorg = {
        #     enabled = true;
        #     clearInInsertMode = true;
        #     onlyRenderImageAtCursor = true;
        #     filetypes = [ "norg" ];
        #   };
        # };

        neogit = {
          enable = true;
        };

        auto-save = {
          enable = true;
        };

        orgmode = {
          enable = true;
          settings = {
            org_agenda_files = "~/Documents/Org/**/*";
            org_default_notes_file = "~/Documents/Org/refile.org";
          };
        };

        otter = {
          enable = true;
        };
      };
      # Options for Neorg to work well
      extraConfigLua = # lua
        ''
                    require 'typst-preview'.setup {
                      follow_cursor = true,
                      open_cmd = "chromium %s",
                      dependencies_bin = {
                        ['typst-preview'] = "tinymist",
                        ['websocat'] = "websocat",
                      },
                    }

          local severity = vim.diagnostic.severity
          vim.diagnostic.config({
            underline = {
              enable = true,
              severity = {
                min = severity.WARN,
              },
            },
            virtual_lines = {
              enable = true,
              current_line = true,
            },
            signs = {
              severity = {
                min = severity.HINT,
              },
              -- I don't like sign collumn
              text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.INFO] = "",
                [vim.diagnostic.severity.HINT] = "",
              },
              numhl = {
                [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
                [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
                [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
                [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
              },
            },
            virtual_text = false,
            -- virtual_lines = true,
            -- underline = true,
            update_in_insert = true,
            severity_sort = true,
            float = {
              source = "if_many",
              border = "rounded",
              show_header = false,
            },
          })

        '';
    };
  };
}
