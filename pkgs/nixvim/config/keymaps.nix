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
      # Helix comment maps
      {
        action = "<cmd>norm gcc<CR>";
        key = "<C-c>";
        mode = "n";
      }
      {
        action = "<cmd>norm gc<CR>";
        key = "<C-c>";
        mode = "v";
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
    ++ lib.optionals config.plugins.telescope.enable [
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
    ++ lib.optionals (config.plugins.snacks.settings.picker.enabled && config.plugins.snacks.enable) [
      {
        action = "<cmd>lua Snacks.picker.recent()<CR>";
        key = "<leader>fr";
        mode = "n";
        options.desc = "Recent files";
      }
      {
        action = "<cmd>lua Snacks.picker.files()<CR>";
        key = "<leader>ff";
        mode = "n";
        options.desc = "Find Files";
      }
      {
        action = "<cmd>lua Snacks.picker.diagnostics()<CR>";
        key = "<leader>d";
        mode = "n";
        options.desc = "Show diagnostics";
      }
      {
        action = "<cmd>lua Snacks.picker.grep()<CR>";
        key = "<leader>fs";
        mode = "n";
        options.desc = "Rip-grep";
      }
      {
        action = "<cmd>lua Snacks.picker.grep_buffers()<CR>";
        key = "<leader>fc";
        mode = "n";
        options.desc = "Grep openned buffers";
      }
      {
        action = "<cmd>lua Snacks.picker.buffers()<CR>";
        key = "<leader>b";
        mode = "n";
        options.desc = "List buffers";
      }
      {
        action = "<cmd>lua Snacks.picker.lsp_config()<CR>";
        key = "<leader>fl";
        mode = "n";
        options.desc = "Show LSP config";
      }
      {
        action = "<cmd>lua Snacks.picker.help()<CR>";
        key = "<f1>";
        mode = "n";
        options.desc = ":h";
      }
      {
        action = "<cmd>lua Snacks.picker.undo()<CR>";
        key = "<leader>fu";
        mode = "n";
        options.desc = "Undo history";
      }
      {
        action = "<cmd>lua Snacks.picker.icons()<CR>";
        key = "<leader>fi";
        mode = "n";
        options.desc = "Icon browser";
      }
      {
        action = "<cmd>lua Snacks.picker.highlights()<CR>";
        key = "<leader>fh";
        mode = "n";
        options.desc = "Highlight list";
      }
      {
        action = "<cmd>lua Snacks.picker.pick()<CR>";
        key = "<leader>fp";
        mode = "n";
        options.desc = "Picker picker";
      }
      {
        action = "<cmd>lua Snacks.picker.command_history()<CR>";
        key = "<leader>f?";
        mode = "n";
        options.desc = "Command history";
      }
      {
        action = "<cmd>lua Snacks.picker.spelling()<CR>";
        key = "z=";
        mode = "n";
        options.desc = "Spelling list";
      }
    ]
    ++ lib.optionals config.plugins.neorg.enable [
      #Neorg Journal
      {
        action = "<cmd>Neorg journal today<CR>";
        key = "<leader>j";
        mode = "n";
        options.desc = "Journal today";
      }
    ]
    ++ lib.optionals (config.plugins.neorg.enable && config.plugins.telescope.enable) [
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
    ]
    ++ lib.optionals config.plugins.neogit.enable [
      # NeoGit
      {
        action = "<cmd>Neogit<CR>";
        key = "<leader>g";
        mode = "n";
      }
    ]

    ++ lib.optionals config.plugins.oil.enable [
      # Oil
      {
        action = "<cmd>Oil<CR>";
        key = "<leader>e";
        mode = "n";
      }
    ];
}
