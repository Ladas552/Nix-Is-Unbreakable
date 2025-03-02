{ pkgs, lib, ... }:
{
  # Todo
  # edit "open" command to pistol as tutorial
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
      e = "open-nvim";
      E = "open-hx";
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
      i = ''$\${lib.getExe' pkgs.bat "bat"} "$f"'';
      a = "rename";
      r = "";
      "<backspace2>" = "set hidden!";
      "<enter>" = "open";
      f = "search";
      F = "filter";
    };
    cmdKeybindings = {
      "<tab>" = "cmd-menu-complete";
      "<backtab>" = "cmd-menu-complete-back";
    };
    extraConfig =
      let
        previewer = pkgs.writeShellScriptBin "pv.sh" #bash
        ''
          file=$1
          w=$2
          h=$3
          x=$4
          y=$5

          if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
              ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
              exit 1
          fi

          ${pkgs.pistol}/bin/pistol "$file"
        '';
        cleaner = pkgs.writeShellScriptBin "clean.sh" #bash
        ''
          ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
        '';
      in
      ''
        set cleaner ${cleaner}/bin/clean.sh
        set previewer ${previewer}/bin/pv.sh
      '';
  };
}
