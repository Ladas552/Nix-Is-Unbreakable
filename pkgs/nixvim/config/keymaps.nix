{
  lib,
  config,
  meta,
  ...
}:
{

  globals.mapleader = " ";
  keymaps =
    #Normal Key binds
    [
      # AntiUndo
      {
        action = "<cmd>redo<CR>";
        key = "<S-u>";
        mode = "n";
      }
      # Disable accidentally pressing Ctrl-Z and suspending Neovim
      {
        action = "<Nop>";
        key = "<C-z>";
        mode = "n";
      }
      # Disable ex-mode
      {
        action = "<Nop>";
        key = "Q";
        mode = "n";
      }
      # Fast command-line mode
      {
        action = ":";
        key = ";";
        mode = "n";
      }
      # ESC to turn off search highlighting
      {
        action = "<cmd>nohlsearch<CR>";
        key = "<esc>";
        mode = "n";
      }
      # Stay in visual mode after indenting with < or >
      {
        action = ">gv";
        key = ">";
        mode = "n";
      }
      {
        action = "<gv";
        key = "<";
        mode = "n";
      }
      # Exit insert mode in terminal
      {
        action = "<C-\\><C-n>";
        key = "<esc>";
        mode = "t";
      }
      # Move between windows
      {
        action = "<C-w>h";
        key = "<S-Left>";
        mode = "n";
      }
      {
        action = "<C-w>j";
        key = "<S-Down>";
        mode = "n";
      }
      {
        action = "<C-w>k";
        key = "<S-Up>";
        mode = "n";
      }
      {
        action = "<C-w>l";
        key = "<S-Right>";
        mode = "n";
      }
      # Resize splits
      {
        action = "<cmd>resize +2<cr>";
        key = "<A-Up>";
        mode = "n";
      }
      {
        action = "<cmd>resize -2<cr>";
        key = "<A-Down>";
        mode = "n";
      }
      {
        action = "<cmd>vertical resize +2<cr>";
        key = "<A-Left>";
        mode = "n";
      }
      {
        action = "<cmd>vertical resize -2<cr>";
        key = "<A-Right>";
        mode = "n";
      }
    ]
    ++ lib.optionals (!meta.isTermux) [
      #Buffer Navigation Desktop
      {
        action = "<cmd>bprevious<CR>";
        key = "<leader>,";
        mode = "n";
        options.desc = "Left Buffer";
      }
      {
        action = "<cmd>bnext<CR>";
        key = "<leader>.";
        mode = "n";
        options.desc = "Right Buffer";
      }
    ]
    ++ lib.optionals meta.isTermux [
      #Buffer Navigation Termux
      {
        action = "<cmd>bprevious<CR>";
        key = "<leader>.";
        mode = "n";
        options.desc = "Left Buffer";
      }
      {
        action = "<cmd>bnext<CR>";
        key = "<leader>,";
        mode = "n";
        options.desc = "Right Buffer";
      }
    ]
    ++ [
      # Close Buffer
      {
        action = "<cmd>bdelete<CR>";
        key = "<leader>x";
        mode = "n";
        options.desc = "Close Buffer";
      }
    ]
    # a way to add the list to other list, if certain plugin is enabled
    # `optionalAttrs` is for sets, hence "attrs". for lists use `optionals`
    ++ lib.optionals config.plugins.flash.enable [
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
    ];
}
