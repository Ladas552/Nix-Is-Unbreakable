{ config, pkgs, ... }:
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
  volt = pkgs.vimUtils.buildVimPlugin {
    name = "volt";
    src = pkgs.fetchFromGitHub {
      owner = "NvChad";
      repo = "volt";
      rev = "43f72b49037c191eb3cfe26ba7a5574b4bfce226";
      sha256 = "19lxsiphq9i6glc99khn6krf81hjhyhqzxc2rgfa2dryvdmi3b9x";
    };
  };

  menu = pkgs.vimUtils.buildVimPlugin {
    name = "menu";
    src = pkgs.fetchFromGitHub {
      owner = "NvChad";
      repo = "menu";
      rev = "1d5771c729226b5b1e4a84b5da38ba2789fd41b4";
      sha256 = "1n4v6r40wlpq4yipn9ifq0012baqh2jaxqlk2pr7r9mxd25h85d8";
    };
  };

  typst-preview = pkgs.vimUtils.buildVimPlugin {
    name = "typst-preview";
    src = pkgs.fetchFromGitHub {
      owner = "chomosuke";
      repo = "typst-preview.nvim";
      rev = "0354cc1a7a5174a2e69cdc21c4db9a3ee18bb20a";
      sha256 = "0vrqj77n5cjabkak4j2m58i3rbrp0w37ggd49gfib5abf9qxyi4z";
    };
  };
in
{

  #formatters
  home.packages = with pkgs; [
    black
    prettierd
    stylua
    # typix web integration
    websocat
  ];

  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins."gitsigns-nvim"
      pkgs.vimPlugins."lspkind-nvim"
      pkgs.vimPlugins."overseer-nvim"
      pkgs.vimPlugins.nvim-treesitter-parsers.org
      typst-preview
      treesitter-norg-meta
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
        servers = {
          # lua_ls = {
          #   enable = true;
          #   settings.diagnostics.globals = [
          #     "vim"
          #     "cmp"
          #   ];
          # };
          nil_ls.enable = true;
          yamlls.enable = true;
          tinymist = {
            enable = true;
            settings = {
              exportPdf = "onType";
            };
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

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lspFallback = true;
            timeoutMs = 500;
          };
          formatters_by_ft = {
            python = [ "black" ];
            lua = [ "stylua" ];
            markdown = [ [ "prettierd" ] ];
          };
        };
      };

      luasnip.enable = true;
      friendly-snippets.enable = true;
      lint.enable = true;
      trim.enable = true;
      #UI
      which-key = {
        enable = true;
      };

      lsp-lines = {
        enable = true;
      };

      lsp-status = {
        enable = true;
      };

      arrow = {
        enable = true;
        settings = {
          show_icons = true;
          full_path_list = [ "update_stuff" ];
          save_path = ''
            function()
              return vim.fn.stdpath("cache") .. "/arrow"
            end
          '';
          global_bookmarks = true;
          always_show_path = true;
          separate_by_branch = true;
          buffer_leader_key = "m";
        };
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

      nvim-colorizer.enable = true;

      telescope = {
        enable = true;
        extensions.manix.enable = true;
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
      #cmp
      cmp = {
        enable = true;
        autoEnableSources = false;
        settings = {
          completion.completeopt = "menu,menuone,preview,noselect";
          snippet.expand = # lua
            ''
              function(args)
                require("luasnip").lsp_expand(args.body)
              end,
            '';
          sources = {
            __raw = # lua
              ''
                cmp.config.sources({
                  { name = "nvim_lsp" },
                  { name = "luasnip" }, -- snippets
                  { name = "buffer" }, -- text within current buffer
                  { name = "path" }, -- file system paths
                  { name = "neorg" },
                  --  { name = "codeium" },
                  { name = "copilot" },
                  { name = "bashls" },
                  { name = "lua_ls" },
                  { name = "nil_ls" },
                }),
              '';
          };
          mapping = {
            __raw = # lua
              ''
                cmp.mapping.preset.insert({
                  ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                  ["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
                  ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                  ["<C-f>"] = cmp.mapping.scroll_docs(4),
                  ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                  ["<ESC>"] = cmp.mapping.abort(), -- close completion window
                  ["<CR>"] = cmp.mapping.confirm({ select = false }),
                })
              '';
          };
          formatting = {
            format = # lua
              ''
                require("lspkind").cmp_format({
                  maxwidth = 50,
                  ellipsis_char = "...",
                  mode = "symbol",
                  symbol_map = { Copilot = "" },
                }),
              '';
          };
        };
      };

      cmp-path.enable = true;
      cmp-buffer.enable = true;
      cmp_luasnip.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-spell.enable = true;
      copilot-cmp.enable = true;
      #AI
      copilot-lua = {
        enable = true;
        panel.enabled = false;
        suggestion.enabled = false;
        filetypes = {
          javascript = true;
          typescript = true;
          rust = true;
          python = true;
          lua = true;
          nix = true;
          "*" = false;
        };
      };

      # codeium-nvim = {
      #   enable = true;
      # };
      #Workflow
      wtf = {
        enable = true;
        context = true;
      };

      oil = {
        enable = true;
        settings = {
          delete_to_trash = true;
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

      nix.enable = true;

      treesitter = {
        enable = true;
        folding = true;
        nixvimInjections = true;
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          treesitter-norg-meta
          bash
          bibtex
          c
          cmake
          org
          comment
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
          latex
          lua
          luadoc
          make
          markdown
          markdown_inline
          meson
          ninja
          nix
          norg
          org
          python
          rasi
          requirements
          rust
          sql
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

      image = {
        enable = true;
        windowOverlapClearEnabled = true;
        integrations.neorg = {
          enabled = true;
          clearInInsertMode = true;
          onlyRenderImageAtCursor = true;
          filetypes = [ "norg" ];
        };
      };

      # typst-vim = {
      #   enable = true;
      #   settings = {
      #     auto_close_toc = 1;
      #     typst_auto_open_quickfix = 0;
      #     pdf_viewer = "zathura";
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
      #Guffy
      presence-nvim = {
        enable = true;
        blacklist = [
          "norg"
          "txt"
        ];
        neovimImageText = "I am showing off, yeah";
      };
      # Neorg
      neorg = {
        enable = true;
        modules = {
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
              report_on_empty = false;
              tangle_on_write = true;
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
                general = "~/Documents/Norg";
                life = "~/Documents/Norg/Life";
                work = "~/Documents/Norg/Study";
                journal = "~/Documents/Norg/Journal";
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
          "core.todo-introspector" = {
            __empty = null;
          };
          "core.ui.calendar" = {
            __empty = null;
          };
          "core.integrations.image" = {
            __empty = null;
          };
          "core.integrations.telescope" = {
            __empty = null;
          };
        };
      };
      #  lazy = {
      #    enable = true;
      #    plugins = [
      #      {
      #        pkg = volt;
      #        name = "nvchad/volt";
      #      }
      #      {
      #        pkg = menu;
      #        name = "nvchad/menu";
      #        keys = {
      #          __raw = # lua
      #            ''
      #              vim.keymap.set("n", "<RightMouse>", function()
      #                vim.cmd.exec "normal! \\<RightMouse>"
      #                end, {})
      #            '';
      #        };
      #      }
      #    ];
      #  };
    };
    # Options for Neorg to work well
    extraConfigLua = # lua
      ''
        vim.g.maplocalleader = "  "
        vim.wo.foldlevel = 99
        vim.wo.conceallevel = 2
        require 'typst-preview'.setup {
          follow_cursor = true,
          open_cmd = "chromium %s",
          dependencies_bin = {
            ['typst-preview'] = "tinymist",
            ['websocat'] = "websocat",
          },
        }
      '';
  };
}
