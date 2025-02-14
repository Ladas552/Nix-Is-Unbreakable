{
  lib,
  config,
  meta,
  ...
}:
{

  options.customhm = {
    nixvim.keymaps = lib.mkEnableOption "neovim keymaps that i prefer";
  };

  config = lib.mkIf (config.customhm.nixvim.enable && config.customhm.nixvim.keymaps) {

    programs.nixvim = {
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
          # Do not copy on paste
          {
            action = "_dP";
            key = "p";
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
        ]
        ++ lib.optionals meta.isTermux [
          #Buffer Navigation Termux
          {
            action = "<cmd>BufferPrevious<CR>";
            key = "<leader>.";
            mode = "n";
            options.desc = "Left Buffer";
          }
          {
            action = "<cmd>BufferNext<CR>";
            key = "<leader>,";
            mode = "n";
            options.desc = "Right Buffer";
          }
        ]
        ++ [
          # Close Buffer
          {
            action = "<cmd>BufferClose<CR>";
            key = "<leader>x";
            mode = "n";
            options.desc = "Close Buffer";
          }
        ]
        #Plugins
        ++ [
          #Neorg Journal
          {
            action = "<cmd>Neorg journal today<CR>";
            key = "<leader>j";
            mode = "n";
            options.desc = "Journal today";
          }
        ]
        ++ [
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
        ]
        ++ lib.optionals config.programs.nixvim.plugins.neorg.enable [
          # Telescope Neorg Integration
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
        ++ lib.optionals (!meta.isTermux) [
          # Img-clip.nvim
          {
            action = "<cmd>PasteImage<CR>";
            key = "<leader>p";
            mode = "n";
            options.desc = "Paste image";
          }
        ]
        # a way to add the list to other list, if certain plugin is enabled
        # `optionalAttrs` is for sets, hence "attrs". for lists use `optionals`
        ++ lib.optionals config.programs.nixvim.plugins.flash.enable [
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
        ++ lib.optionals config.programs.nixvim.plugins.neogit.enable [
          # NeoGit
          {
            action = "<cmd>Neogit<CR>";
            key = "<leader>g";
            mode = "n";
          }
        ]

        ++ lib.optionals config.programs.nixvim.plugins.oil.enable [
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
