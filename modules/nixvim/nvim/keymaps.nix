{ config, pkgs, inputs, ... }:
{
  programs.nixvim = {
    globals.mapleader = " ";
    keymaps = [
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
      #Neorg Workspaces
      {
        action = "<cmd>Neorg workspace life<CR>";
        key = "<leader>nl";
        mode = "n";
        options.desc = "Life Workspace";
      }
      {
        action = "<cmd>Neorg workspace work<CR>";
        key = "<leader>nw";
        mode = "n";
        options.desc = "Study Workspace";
      }
      {
        action = "<cmd>Neorg workspace journal<CR>";
        key = "<leader>nn";
        mode = "n";
        options.desc = "Journal Workspace";
      }
      #Neorg Journal
      {
        action = "<cmd>Neorg journal today<CR>";
        key = "<leader>jt";
        mode = "n";
        options.desc = "Today";
      }
      {
        action = "<cmd>Neorg journal yesterday<CR>";
        key = "<leader>jy";
        mode = "n";
        options.desc = "Yesterday";
      }
      {
        action = "<cmd>Neorg journal tomorrow<CR>";
        key = "<leader>jT";
        mode = "n";
        options.desc = "Tomorrow";
      }
      #Oil
      {
        action = "<cmd>Oil<CR>";
        key = "<leader>ef";
        mode = "n";
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
      # NeoGit
      {
        action = "<cmd>Neogit<CR>";
        key = "<leader>gg";
        mode = "n";
      }
    ];
  };
}
