{
  pkgs,
  lib,
  config,
  meta,
  inputs,
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

  heirline-components = pkgs.vimUtils.buildVimPlugin {
    name = "heirline-components.nvim";
    doCheck = false;
    src = pkgs.fetchFromGitHub {
      owner = "Zeioth";
      repo = "heirline-components.nvim";
      rev = "935f29dabd86f2669e0b3c8dd283b2d3b1cfaee7";
      sha256 = "sha256-M2muEW4RFQxdaJjZaXMXosy0M7Zj4MlbITRpRWpinwo=";
    };
  };
in
{

  config = lib.mkIf (!meta.isTermux) {
    #formatters and dependencies
    extraPackages = with pkgs; [
      black
      stylua
      sqlite
    ];

    performance.combinePlugins = {
      enable = true;
      standalonePlugins = [
        "oil.nvim"
        "typst-preview.nvim"
        "neorg"
        "blink.cmp"
        "snacks.nvim"
        "neorg-query"
      ];
    };
    extraPlugins = [
      pkgs.vimPlugins."gitsigns-nvim"
      pkgs.vimPlugins."lspkind-nvim"
      pkgs.vimPlugins.img-clip-nvim
      pkgs.vimPlugins.heirline-nvim
      pkgs.vimPlugins.numb-nvim
      heirline-components
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

      friendly-snippets.enable = true;
      lint.enable = true;
      #UI
      which-key = {
        enable = true;
      };

      web-devicons = {
        enable = true;
      };

      colorizer.enable = true;

      telescope = {
        enable = false;
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
        nixvimInjections = false;
        grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
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

      typst-preview = {
        enable = true;
        settings = {
          follow_cursor = true;
          open_cmd = "chromium %s";
        };
      };

      snacks = {
        enable = true;
        settings = {
          bigfile.enabled = true;
          image = {
            enabled = false;
            doc.inline = false;
            doc.float = true;
            convert.notify = false;
          };
          picker = {
            enabled = true;
          };
        };
        # only make it load on specific file types
        luaConfig.post = ''
          require("snacks.image").langs = function ()
            return {"markdown", "typst", "norg"}
          end
        '';
      };

      cord = lib.mkIf (meta.host != "") {
        enable = true;
        settings = {
          editor = {
            client = "1375074497681690665";
            tooltip = "Nix flavored Neovim";
            icon = "nixvim_logo";
          };
          display = {
            theme = "catppuccin";
            flavor = "accent";
          };
          text = {
            default = "Editing in Neovim";
            workspace = "Moving Blazingly Fast";
            viewing = "Viewing in Neovim";
            docs = "RTFMing";
            vcs = "Solving git conflicts";
            notes = "Norging it";
            dashboard = "In ~";
          };
        };
      };
    };
    extraConfigLua = # lua
      ''
        -- peek into `:42` move
        -- has a bug with `:+n` commands
        -- https://github.com/nacro90/numb.nvim/issues/33
        require('numb').setup{
          show_numbers = true, -- Enable 'number' for the window while peeking
          show_cursorline = false, -- Enable 'cursorline' for the window while peeking
          hide_relativenumbers = true, -- Enable turning off 'relativenumber' for the window while peeking
          number_only = true, -- Peek only when the command is only a number instead of when it starts with a number
          centered_peeking = true, -- Peeked line will be centered relative to window
        }

        -- lsp.config
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

        -- Heirline config
        local lib = require "heirline-components.all"
        local heirline = require("heirline")
        local heirline_components = require "heirline-components.all"
        --- only show bufferline when more than 1 buffer
        local get_bufs = function()
            return vim.tbl_filter(function(bufnr)
                return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
            end, vim.api.nvim_list_bufs())
        end
        local buflist_cache = {}
        vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
            callback = function()
                vim.schedule(function()
                    local buffers = get_bufs()
                    for i, v in ipairs(buffers) do
                        buflist_cache[i] = v
                    end
                    for i = #buffers + 1, #buflist_cache do
                        buflist_cache[i] = nil
                    end

                    -- check how many buffers we have and set showtabline accordingly
                    if #buflist_cache > 1 then
                        vim.o.showtabline = 2 -- always
                    elseif vim.o.showtabline ~= 1 then -- don't reset the option if it's already at default value
                        vim.o.showtabline = 1 -- only when #tabpages > 1
                    end
                end)
            end,
        })
        --- using heirline-components modules
        heirline_components.init.subscribe_to_events()
        heirline.load_colors(heirline_components.hl.get_colors())
        heirline.setup({
          tabline = {
            lib.component.tabline_buffers({surround = {},}),
            lib.component.fill { hl = { bg = "bg", fg = "fg" } },
            lib.component.tabline_tabpages()
          },
          statuscolumn = {
            init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
            -- minimal padding can be achived with `set numberwidth = 1`
            lib.component.numbercolumn({padding = { right = 0, left = 0, },}),
          } or nil,
          statusline = {
            hl = { fg = "fg", bg = "bg" },
            lib.component.mode({mode_text = {},}),
            lib.component.file_info({filename = {}, filetype = false, file_modified = {},}),
            lib.component.fill(),
            lib.component.diagnostics({}),
            lib.component.nav({ruler = { padding = { right = 1 } },scrollbar = false,percentage = false,}),
          },
          opts = {
          },
        })
      '';
  };
}
