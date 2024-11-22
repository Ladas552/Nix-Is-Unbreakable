{ pkgs, ... }:
{

  programs.lf = {
    commands = {
      trash = ''%${pkgs.trash-cli}/bin/trash-put "$fx"'';
      editor-open = ''$$EDITOR $f'';
      # mkdir = ''
      #   ''${{
      #     printf "Directory Name: "
      #     read DIR
      #     mkdir $DIR
      #     }}
      # '';
    };
    keybindings = {
      D = "trash";
      "<f-7>" = ''push %$mkdir<space>""<c-b>'';
      "<f-1>" = ''push %$touch<space>""<c-b>'';
    };
  };
}
