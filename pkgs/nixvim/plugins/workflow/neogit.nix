{ pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins."gitsigns-nvim" ];
  plugins.neogit.enable = true;
}
