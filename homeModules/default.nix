{
  lib,
  config,
  meta,
  ...
}:

{
  imports = [
    ./chromium
    ./direnv
    ./emacs
    ./fastfetch
    ./thunderbird
    ./flameshot
    ./gh
    ./ghostty
    ./git
    ./helix
    ./imv
    ./kitty
    ./mako
    ./mangohud
    ./mpd
    ./mpv
    ./nixvim
    ./neovim
    ./nvf
    ./obs
    ./rofi
    ./qutebrowser
    ./lf
    ./ranger
    ./shell
    ./swaylock
    ./syncthing
    ./wpaperd
    ./vim
    ./yt-dlp
    ./zathura
  ];
  manual.manpages.enable = false;
  customhm = {
    nixvim = lib.mkDefault {
      autocmd = config.customhm.nixvim.enable;
      options = config.customhm.nixvim.enable;
      keymaps = config.customhm.nixvim.enable;
      colorschemes.catppuccin = config.customhm.nixvim.enable;
      plugins = {
        NixToks = config.customhm.nixvim.enable && (!meta.isTermux);
        NixMux = config.customhm.nixvim.enable && meta.isTermux;
        Neorg = config.customhm.nixvim.enable;
      };
    };
    nvf = lib.mkDefault {
      # autocmd = config.customhm.nvf.enable;
      # options = config.customhm.nvf.enable;
      # keymaps = config.customhm.nvf.enable;
      # colorschemes.catppuccin = config.customhm.nvf.enable;
      plugins = {
        NixToks = config.customhm.nvf.enable && (!meta.isTermux);
        # NixMux = config.customhm.nvf.enable && meta.isTermux;
        Neorg = config.customhm.nvf.enable;
      };
    };
    shell.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
  };
}
