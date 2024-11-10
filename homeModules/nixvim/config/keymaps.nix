{ lib, config, ... }:
{

  options.customhm = {
    nixvim.keymaps = lib.mkEnableOption "neovim keymaps that i prefer";
  };

  config = lib.mkIf config.customhm.nixvim.keymaps {

    programs.nixvim = {
      globals.mapleader = " ";
      keymaps =
        [
          #Normal Key binds
          {
            action = "<cmd>redo<CR>";
            key = "<S-u>";
            mode = "n";
          }
          #Buffer Navigation
          {
            action = "<cmd>BufferPrevious<CR>";
            key = "<leader>,";
            mode = "n";
            options.desc = "Left Buffer";
          }
          {
            action = "<cmd>BufferNext<CR>";
            key = "<leader>.";
            mode = "n";
            options.desc = "Right Buffer";
          }
          {
            action = "<cmd>BufferClose<CR>";
            key = "<leader>x";
            mode = "n";
            options.desc = "Close Buffer";
          }
          #Plugins
          #Neorg Journal
          {
            action = "<cmd>Neorg journal today<CR>";
            key = "<leader>j";
            mode = "n";
            options.desc = "Journal today";
          }
          #Telescope
          {
            action = "<cmd>Telescope find_files<CR>";
            key = "<leader>ff";
            mode = "n";
            options.desc = "Find Files";
          }
          {
            action = "<cmd>Telescope oldfiles<CR>";
            key = "<leader>fr";
            mode = "n";
            options.desc = "Recent Files";
          }
          {
            action = "<cmd>Telescope live_grep<CR>";
            key = "<leader>fs";
            mode = "n";
            options.desc = "Rip-grep";
          }
          {
            action = "<cmd>Telescope grep_string<CR>";
            key = "<leader>fc";
            mode = "n";
            options.desc = "Grep current buffer";
          }
          {
            action = "<cmd>Telescope neorg find_norg_files<CR>";
            key = "<leader>fn";
            mode = "n";
            options.desc = "Find Norg File";
          }
          {
            action = "<cmd>Telescope neorg switch_workspace<CR>";
            key = "<leader>n";
            mode = "n";
            options.desc = "Change Neorg Workspace";
          }
        ]
        # a way to add the list to other list, if certain plugin is enabled
        ++ lib.optionalAttrs config.programs.nixvim.plugins.flash.enable [
          # Flash
          {
            key = "s";
            action.__raw = ''require("flash").remote'';
            options.desc = "Flash";
          }
          {
            key = "S";
            action.__raw = ''require("flash").treesitter'';
            options.desc = "Flash treesitter";
          }
        ]
        ++ lib.optionalAttrs config.programs.nixvim.plugins.neogit.enable [
          # NeoGit
          {
            action = "<cmd>Neogit<CR>";
            key = "<leader>g";
            mode = "n";
          }
        ]

        ++ lib.optionalAttrs config.programs.nixvim.plugins.oil.enable [
          # Oil
          {
            action = "<cmd>Oil<CR>";
            key = "<leader>e";
            mode = "n";
          }
        ];
    };
  };
}
