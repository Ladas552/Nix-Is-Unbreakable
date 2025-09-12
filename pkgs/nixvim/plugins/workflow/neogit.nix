{ pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins."gitsigns-nvim" ];
  plugins.neogit.enable = true;
  keymaps = [
    # NeoGit
    {
      action = "<cmd>Neogit<CR>";
      key = "<leader>g";
      mode = "n";
    }
  ];
}
