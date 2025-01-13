{
  pkgs,
  lib,
  config,
  ...
}:
let
  img-clip.nvim = pkgs.vimUtils.buildVimPlugin {
    name = "img-clip.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "HakonHarnes";
      repo = "img-clip.nvim";
      rev = "28a32d811d69042f4fa5c3d5fa35571df2bc1623";
      sha256 = "0yi94bsr3yja619lrh9npsqrzvbk2207j3wnzdvidbbb1nix2dsd";
    };
  };

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
    nixvim.plugins.NixMux = lib.mkEnableOption "neovim plugins for mobile";
  };

  config = lib.mkIf config.customhm.nixvim.plugins.NixMux {

    programs.nixvim = {
      extraPlugins = [
        pkgs.vimPlugins."gitsigns-nvim"
        img-clip.nvim
        #typst-tools.nvim
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

        telescope = {
          enable = true;
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
              center = [
                {
                  action = "Telescope oldfiles";
                  desc = " Recent files";
                  icon = "󰥔 ";
                  key = "R";
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
            sources = [
              { name = "buffer"; }
              { name = "path"; }
              { name = "neorg"; }
              { name = "luasnip"; }
            ];
            mapping = {
              "<S-Tab>" = "cmp.mapping.select_prev_item()"; # previous suggestion
              "<Tab>" = "cmp.mapping.select_next_item()"; # next suggestion
              "<C-b>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-Space>" = "cmp.mapping.complete()"; # show completion suggestions
              "<ESC>" = "cmp.mapping.abort()"; # close completion window
              "<CR>" = "cmp.mapping.confirm { select = false }";
            };
          };
        };
        cmp-path.enable = true;
        cmp-buffer.enable = true;
        cmp_luasnip.enable = true;
        cmp-spell.enable = true;
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
          grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
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

        flash.enable = true;

        auto-save = {
          enable = true;
        };
      };
    };
  };
}
