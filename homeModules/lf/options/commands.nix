{
  pkgs,
  config,
  lib,
  ...
}:
{
  # Todo
  ## edit "open" command to custom opener script with defined filename-program pattern
  ## make `dircounts false` and `calcdirsize` with a simple command, and the same one to revert the count back
  programs.lf = {
    commands = {
      trash = ''%${lib.getExe' pkgs.trash-cli "trash-put"} "$fx"'';
      open-nvim = ''$nvim $f'';
      open-hx = if config.programs.helix.enable then ''$hx $f'' else ''$nvim $f'';
      q = ''quit'';
      touch = # bash
        ''
          %{{
          printf "Create file/directory: "
          read -r target
          if [ -n "$target" ]; then
          ${lib.getExe' pkgs.bonk "bonk"} "$target"
          lf -remote "send $ip reload"
          fi
          }}
        '';
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
      "<f-7>" = ''touch'';
      "<f-1>" = ''touch'';
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
      source = "${lib.meta.getExe' pkgs.ctpv "ctpv"}";
    };
    extraConfig = # bash
      ''
        &${lib.meta.getExe' pkgs.ctpv "ctpv"} -s $id
        cmd on-quit %${lib.meta.getExe' pkgs.ctpv "ctpv"} -e $id
        set cleaner ${lib.meta.getExe' pkgs.ctpv "ctpvclear"}
      '';
  };
}
