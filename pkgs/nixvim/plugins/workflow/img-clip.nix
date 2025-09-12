{ pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins.img-clip-nvim ];
  keymaps = [
    # Img-clip.nvim
    {
      action = "<cmd>PasteImage<CR>";
      key = "<leader>p";
      mode = "n";
      options.desc = "Paste image";
    }
  ];
}
