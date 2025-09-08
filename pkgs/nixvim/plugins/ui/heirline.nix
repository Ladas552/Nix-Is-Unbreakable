{ pkgs, ... }:
let
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
  extraPlugins = [
    pkgs.vimPlugins.heirline-nvim
    heirline-components
  ];
  extraConfigLua = # lua
    ''
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

}
