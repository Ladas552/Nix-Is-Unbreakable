{ pkgs, lib, ... }:
{
# Todo
# edit "open" command to pistol as tutorial
  programs.lf = {
    commands = {
      trash = ''%${lib.getExe' pkgs.trash-cli "trash-put"} "$fx"'';
      open-nvim = ''$nvim $f'';
      open-hx = ''$hx $f'';
      q = "quit";
      # mkdir = ''
      #   ''${{
      #     printf "Directory Name: "
      #     read DIR
      #     mkdir $DIR
      #     }}
      # '';
    };
    keybindings = {
      e = "open-nvim";
      E = "open-hx";
      Dd = "trash";
      DD = "delete";
      "<f-7>" = ''push %mkdir<space>""<c-b>'';
      "<f-1>" = ''push %touch<space>""<c-b>'';
      V = "unselect";
      "<esc>" = '':unselect;clear'';
      t = ":tag-toggle; down";
      w = "";
      S = "$fish";
      i = ''$\${lib.getExe' pkgs.bat "bat"} "$f"'';
      a = "rename";
      r = "";
      "<backspace2>" = "set hidden!";
    };
    cmdKeybindings = {
      "<tab>" = "cmd-menu-complete";
      "<backtab>" = "cmd-menu-complete-back";
    };
    previewer = {
      keybinding = "i";
      source = null;
    };
  };
}
