{ lib, config, ... }:
{
  autoCmd = [
    {
      desc = "highlight yanked text";
      event = [ "textyankpost" ];
      pattern = [ "*" ];
      callback.__raw = # lua
        ''function() vim.highlight.on_yank({ higroup = 'visual', timeout = 300 }) end'';
    }
    {
      desc = "Preserve last editing position";
      event = [ "BufReadPost" ];
      pattern = [ "*" ];
      callback.__raw = # lua
        ''function() if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then vim.cmd("normal! g'\"") end end'';
    }

    {
      desc = "Quickly exit help pages";
      event = [ "FileType" ];
      pattern = [
        "help"
        "notify"
        "checkhealth"
      ];
      callback.__raw = # lua
        ''
          function() vim.keymap.set("n", "q", "<cmd>close<cr>", { silent = true, buffer = true, }) end
        '';
    }
    {
      desc = "Better Terminal buffer";
      event = [ "TermOpen" ];
      pattern = [ "term://*" ];
      callback.__raw = # lua
        ''function() vim.opt_local.spell = false vim.cmd("startinsert!") end'';
    }
  ];
}
