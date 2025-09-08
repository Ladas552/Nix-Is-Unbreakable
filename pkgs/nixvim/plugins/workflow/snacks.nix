{ pkgs, meta, ... }:
{
  performance.combinePlugins.standalonePlugins = [ "snacks.nvim" ];
  extraPackages = [ pkgs.sqlite ];
  plugins.snacks = {
    enable = true;
    settings = {
      bigfile.enabled = true;
      image = {
        enabled = (!meta.isTermux);
        doc.inline = false;
        doc.float = true;
        convert.notify = false;
      };
      picker = {
        enabled = true;
      };
    };
    # only make it load on specific file types
    luaConfig.post = # lua
      ''
        require("snacks.image").langs = function ()
          return {"markdown", "typst", "norg"}
        end
      '';
  };
}
