{ config, pkgs, inputs, ... }:
{
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins."neorg"
      # (pkgs.vimUtils.buildVimPlugin {
      #   name = "neorg-conceal-wrap";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "benlubas";
      #     repo = "neorg-conceal-wrap";
      #     rev = "4e74be759de502bea1027b1a815667039bb2ec10";
      #     sha256 = "0w1rfvbasqdr1lzb3bd2ab9rdvgsm80m3x6r1gvf72bbwizic5g7";
      #     # nix run nixpkgs#nix-prefetch-git https://github.com/benlubas/neorg-conceal-wrap.git
      #   };
      # })
      # (pkgs.vimUtils.buildVimPlugin {
      #   name = "neorg-interim-ls";
      #   src = pkgs.fetchFromGitHub {
      #     owner = "benlubas";
      #     repo = "neorg-interim-ls";
      #     rev = "2ae00fc7ab8c8823c8f602906c4f54acc362f8d9";
      #     sha256 = "0a45nq81pndh98gy1zqznv97mq9rl4fwc0xiijal8im895p3gf80";
      #     # nix run nixpkgs#nix-prefetch-git https://github.com/benlubas/neorg-interim-ls.git
      #   };
      # })
    ];
    extraConfigLua = /*lua*/''
      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
      require("nvim-treesitter.configs").setup {
        highlight = {
          enable = true,
        }
      }
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {
            config = {
              icon_preset = "diamond",
            },
          },
          ["core.summary"] = {},
          ["core.ui.calendar"] = {},
          ["core.latex.renderer"] = { 
            config = { 
              render_on_enter = true, }, },
          ["core.integrations.image"] = {},
          ["core.esupports.metagen"] = { config = { timezone = "implicit-local", type = "empty", undojoin_updates = "false"} },
          ["core.keybinds"] = {
            config = {
              default_keybinds = true,
              neorg_leader = "<Leader><Leader>",
            },
          },
          ["core.journal"] = {
            config = {
              workspace = "journal",
              journal_folder = "/./"
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                general = "~/Documents/Norg/",
                life = "~/Documents/Norg/Life/",
                work = "~/Documents/Norg/Study/",
                journal = "~/Documents/Norg/Journal/",
              },
              default_workspace = "general",
            },
          },
          -- ["core.completion"] = { config = { engine =  { module_name = "external.lsp-completion" } } },
          -- ["external.conceal-wrap"] = {},
          -- ["external.interim-ls"] = {
          --   config = {
          --     completion_provider = {
          --       -- enable/disable the completion provider. On by default.
          --       enable = true,
          --       -- Try to complete categories. Requires benlubas/neorg-se
          --       categories = false,
          --     }
          --   }
          -- },
        },
      })
      ''; 
  };
}

