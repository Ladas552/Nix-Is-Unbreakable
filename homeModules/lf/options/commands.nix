{ pkgs, lib, ... }:
{

  programs.lf = {
    commands = {
      trash = ''%${pkgs.trash-cli}/bin/trash-put "$fx"'';
      editor-open = ''$$EDITOR $f'';
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
      Dd = "trash";
      DD = "delete";
      "<f-7>" = ''push %mkdir<space>""<c-b>'';
      "<f-1>" = ''push %touch<space>""<c-b>'';
      V = "unselect";
      t = ":tag-toggle; down";
      w = "";
      s = "$fish";
      i = ''$\${lib.getExe pkgs.bat} "$f"'';
    };
  };
}
