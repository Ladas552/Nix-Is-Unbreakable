{
  # general options for neovim
  opts = {
    #Numbers on side
    nu = true;
    relativenumber = true;
    numberwidth = 1;
    #Indent
    tabstop = 2; # 2 spaces for tabs (prettier default)
    shiftwidth = 2; # 2 spaces for indent width
    expandtab = true; # expand tab to spaces
    autoindent = true; # copy indent from current line when starting new one
    copyindent = true;
    smartindent = true;
    preserveindent = true;
    #Search
    ignorecase = true; # ignore case when searching
    smartcase = true; # if you include mixed case in your search, assumes you want case-sensitive
    #Colors
    termguicolors = true;
    background = "dark"; # colorschemes that can be light or dark will be made dark
    signcolumn = "yes"; # show sign column so that text doesn't shift
    #Backspace
    backspace = "indent,eol,start"; # allow backspace on indent, end of line or insert mode start position
    #Split windowws
    splitright = true; # split vertical window to the right
    splitbelow = true; # split horizontal window to the bottom
    #Undo
    undofile = true;
    #Scroll
    scrolloff = 8;
    #Update
    updatetime = 50;
    #Spelling
    spelllang = "en_us,ru";
    spell = true;
    #Soft Wrap
    linebreak = true;
    breakindent = true;
    #Go to new directory
    autochdir = true;
    #Clipboard
    clipboard.providers.wl-copy.enable = true;
    #Set cursor coloring in the terminal
    guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor25-Cursor";
    cursorline = true;
    cursorlineopt = "number";
  };

  # Config for diagnostics with lsp
  diagnostic.settings =
    let
      sy = "vim.diagnostic.severity";
      rsy = "__rawKey__vim.diagnostic.severity";
    in
    {
      underline = {
        enable = true;
        severity.min.__raw = ''${sy}.WARN'';
      };
      virtual_lines = {
        enable = true;
        current_line = true;
      };
      virtual_text = false;
      update_in_insert = true;
      severity_sort = true;
      float = {
        source = "if_many";
        border = "rounded";
        show_header = false;
      };
      signs = {
        severity.min.__raw = ''${sy}.HINT'';
        text = {
          "${rsy}.ERROR" = "";
          "${rsy}.WARN" = "";
          "${rsy}.INFO" = "";
          "${rsy}.HINT" = "";
        };
        numhl = {
          "${rsy}.ERROR" = "DiagnosticSignError";
          "${rsy}.WARN" = "DiagnosticSignWarn";
          "${rsy}.INFO" = "DiagnosticSignInfo";
          "${rsy}.HINT" = "DiagnosticSignHint";
        };
      };
    };
}
