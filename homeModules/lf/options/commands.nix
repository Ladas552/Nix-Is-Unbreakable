{ pkgs, lib, ... }:
{
  # Todo
  ## edit "open" command to custom opener script with defined filename-program pattern
  programs.lf = {
    commands = {
      trash = ''%${lib.getExe' pkgs.trash-cli "trash-put"} "$fx"'';
      open-nvim = ''$nvim $f'';
      open-hx = ''$hx $f'';
      q = ''quit'';
      # zoxide integration
      z = # bash
        ''
          %{{
              result="$(zoxide query --exclude "$PWD" "$@" | sed 's/\\/\\\\/g;s/"/\\"/g')"
              lf -remote "send $id cd \"$result\""
          }}
        '';
      on-cd = # bash
        ''
          &{{
            zoxide add "$PWD"
          }}
        '';
    };
    keybindings = {
      # Open text editor
      e = "open-nvim";
      E = "open-hx";
      # Ranger muscle memory
      Dd = "trash";
      DD = "delete";
      "<f-7>" = ''push %mkdir<space>""<c-b>'';
      "<f-1>" = ''push %touch<space>""<c-b>'';
      "<c-d>" = ''quit'';
      V = "unselect";
      "<esc>" = '':unselect;clear'';
      t = ":tag-toggle; down";
      w = "";
      S = "$fish";
      a = "rename";
      r = "";
      "<backspace2>" = "set hidden!";
      "<enter>" = "open";
      # Rebind find to search
      f = "search";
      F = "filter";
      # Zoxide integration
      z = ''push :z<space>'';
    };
    cmdKeybindings = {
      "<tab>" = "cmd-menu-complete";
      "<backtab>" = "cmd-menu-complete-back";
    };
    previewer = {
      keybinding = "i";
      source =
        pkgs.writeShellScript "pv.sh" # bash
          ''
            #!/usr/bin/env bash
            file=$1
              case "$1" in
                *.pdf)  ${lib.getExe' pkgs.poppler-utils "pdftotext"} -layout -q -f 1 -l 3 "$1" -;;
                *)      ${lib.getExe pkgs.pistol} "$1";;
              esac
          '';
    };
  };
}
