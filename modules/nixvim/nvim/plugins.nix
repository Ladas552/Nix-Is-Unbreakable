{ config, pkgs, inputs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins."nvim-web-devicons"
      pkgs.vimPlugins."gitsigns-nvim"
      pkgs.vimPlugins."lspkind-nvim"
      pkgs.vimPlugins."overseer-nvim"
      pkgs.vimPlugins."telescope-manix"
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
      };
      luasnip.enable = true;
      friendly-snippets.enable = true;
      #UI
      which-key = {
        enable = true;
      };

      arrow = {
        enable = true;
        settings = {
          show_icons = true;
          full_path_list = [
            "update_stuff"
          ];
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
        enabledExtensions = [
          "manix"
        ];
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
              ''                                                     ''          
              ''  |                 |               ___|  ___| ___ \ ''
              ''  |       _` |   _` |   _` |   __|  __ \  __ \    ) |''
              ''  |      (   |  (   |  (   | \__ \    ) |   ) |  __/ ''
              '' _____| \__,_| \__,_| \__,_| ____/ ____/ ____/ _____|''
              ''                                                     ''        
            ];
            center = [
              { action = "Telescope oldfiles";   desc = " Recent files"; icon = "󰥔 ";  key = "R";}
              { action = "Telescope find_files"; desc = " Find files";   icon = " ";  key = "F";}
              { action = "ene | startinsert";    desc = " New file";     icon = " ";  key = "N";}
              { action = "Neorg workspace life"; desc = " Neorg Life";   icon = "󰠮 ";  key = "E";}
              { action = "Neorg workspace work"; desc = " Neorg Work";   icon = " ";  key = "W";}
              { action = "Neorg journal today";  desc = " Neorg Journal";icon = "󰛓 ";  key = "J";}
              { action = "qa";                   desc = " Quit";         icon = "󰩈 ";  key = "Q";}
            ];
            footer = ["Just Do Something Already!"];
          };
        };
      };
      #cmp
      cmp = {
        enable = true;
        autoEnableSources = false;
        settings = {
          completion.completeopt = "menu,menuone,preview,noselect";
          snippet.expand = /*lua*/ ''
            function(args)
              require("luasnip").lsp_expand(args.body)
            end,
            '';
            sources = {
            __raw = /*lua*/ ''
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
            __raw = /*lua*/ ''
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
            format = /*lua*/ ''
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
        settings = {
          indent.enable = true;
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
          auto_close_toc = true;
          pdf_viewer = "floorp";
        };
      };


      neogit = {
        enable = true;
      };

      auto-save = {
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

