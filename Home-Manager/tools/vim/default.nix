{ config, pkgs, inputs, ... }:

{
  programs.vim = {
    enable = true;
    settings = {
      relativenumber = true;
      #Indent
      tabstop = 2; # 2 spaces for tabs (prettier default)
      shiftwidth = 2; # 2 spaces for indent width
      expandtab = true; # expand tab to spaces
      #Search
      ignorecase = true; # ignore case when searching
      smartcase = true; # if you include mixed case in your search, assumes you want case-sensitive
      #Colors
      background = "dark"; # colorschemes that can be light or dark will be made dark
    };
  };
}
