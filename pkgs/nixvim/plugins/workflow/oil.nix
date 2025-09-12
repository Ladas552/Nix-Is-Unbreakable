{ meta, ... }:
{
  performance.combinePlugins.standalonePlugins = [ "oil.nvim" ];
  plugins.oil = {
    enable = true;
    settings = {
      delete_to_trash = (!meta.isTermux);
      view_options = {
        show_hidden = true;
      };
    };
  };
  keymaps = [
    # Oil
    {
      action = "<cmd>Oil<CR>";
      key = "<leader>e";
      mode = "n";
    }
  ];
}
