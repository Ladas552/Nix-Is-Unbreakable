{ config, pkgs, inputs, ... }:
{
  programs.nixvim = {
    opts = {
      #Numbers on side 
      nu = true;
      relativenumber = true;
      #Indent
      tabstop = 2; # 2 spaces for tabs (prettier default)
      shiftwidth = 2; # 2 spaces for indent width
      expandtab = true; # expand tab to spaces
      autoindent = true; # copy indent from current line when starting new one
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
      clipboard.providers.xclip.enable = true;
    };
  };
}

