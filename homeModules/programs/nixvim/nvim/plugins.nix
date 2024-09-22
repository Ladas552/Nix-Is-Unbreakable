{ config, pkgs, ... }:
{
  #formatters
  home.packages = with pkgs; [
    black
    nixfmt-rfc-style
    prettierd
    stylua
  ];

  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins."nvim-web-devicons"
      pkgs.vimPlugins."gitsigns-nvim"
      pkgs.vimPlugins."lspkind-nvim"
      pkgs.vimPlugins."overseer-nvim"
      pkgs.vimPlugins."telescope-manix"
      pkgs.vimPlugins.nvim-treesitter-parsers.org
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
      #  neorg = {
      #    enable = true;
      #  };
      #LSP
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          lua-ls.enable = true;
          nil-ls.enable = true;
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
            nix = [ "nixfmt" ];
            markdown = [
              [
                "prettierd"
                "prettier"
              ]
            ];
          };
        };
      };

      luasnip.enable = true;
      friendly-snippets.enable = true;
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

      ccc = {
        enable = true;
        settings = {
          highlighter = {
            auto_enable = true;
          };
        };
      };

      telescope = {
        enable = true;
        enabledExtensions = [ "manix" ];
        settings.defaults = {
          path_display = "truncate ";
        };
      };

      dashboard = {
        enable = true;
        settings = {
          theme = "doom";
          shortcut_type = "number";
          config = {
            header = [
              ""
              "|                 |               ___|  ___| ___ \\ "
              "|       _` |   _` |   _` |   __|  __ \\  __ \\    ) |"
              "|      (   |  (   |  (   | \\__ \\    ) |   ) |  __/ "
              "_____| \\__,_| \\__,_| \\__,_| ____/ ____/ ____/ _____|"
              ""
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
                  { name = "vimtex" }, 
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
      };

      typst-vim = {
        enable = true;
        settings = {
          auto_close_toc = 1;
          pdf_viewer = "zathura";
        };
      };

      vimtex = {
        enable = true;
        texlivePackage = pkgs.texliveFull;
        settings = {
          view_method = "zathura";
        };
      };

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
      # Guffy
      presence-nvim = {
        enable = true;
        blacklist = [
          "norg"
          "txt"
        ];
        neovimImageText = "I am showing off, yeah";

      };
    };
  };
}
