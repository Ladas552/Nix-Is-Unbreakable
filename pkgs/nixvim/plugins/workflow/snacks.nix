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
  keymaps = [
    {
      action = "<cmd>lua Snacks.picker.recent()<CR>";
      key = "<leader>fr";
      mode = "n";
      options.desc = "Recent files";
    }
    {
      action = "<cmd>lua Snacks.picker.files()<CR>";
      key = "<leader>ff";
      mode = "n";
      options.desc = "Find Files";
    }
    {
      action = "<cmd>lua Snacks.picker.diagnostics()<CR>";
      key = "<leader>d";
      mode = "n";
      options.desc = "Show diagnostics";
    }
    {
      action = "<cmd>lua Snacks.picker.grep()<CR>";
      key = "<leader>fs";
      mode = "n";
      options.desc = "Rip-grep";
    }
    {
      action = "<cmd>lua Snacks.picker.grep_buffers()<CR>";
      key = "<leader>fc";
      mode = "n";
      options.desc = "Grep openned buffers";
    }
    {
      action = "<cmd>lua Snacks.picker.buffers()<CR>";
      key = "<leader>b";
      mode = "n";
      options.desc = "List buffers";
    }
    {
      action = "<cmd>lua Snacks.picker.lsp_config()<CR>";
      key = "<leader>fl";
      mode = "n";
      options.desc = "Show LSP config";
    }
    {
      action = "<cmd>lua Snacks.picker.help()<CR>";
      key = "<f1>";
      mode = "n";
      options.desc = ":h";
    }
    {
      action = "<cmd>lua Snacks.picker.undo()<CR>";
      key = "<leader>fu";
      mode = "n";
      options.desc = "Undo history";
    }
    {
      action = "<cmd>lua Snacks.picker.icons()<CR>";
      key = "<leader>fi";
      mode = "n";
      options.desc = "Icon browser";
    }
    {
      action = "<cmd>lua Snacks.picker.highlights()<CR>";
      key = "<leader>fh";
      mode = "n";
      options.desc = "Highlight list";
    }
    {
      action = "<cmd>lua Snacks.picker.pick()<CR>";
      key = "<leader>fp";
      mode = "n";
      options.desc = "Picker picker";
    }
    {
      action = "<cmd>lua Snacks.picker.command_history()<CR>";
      key = "<leader>f?";
      mode = "n";
      options.desc = "Command history";
    }
    {
      action = "<cmd>lua Snacks.picker.spelling()<CR>";
      key = "z=";
      mode = "n";
      options.desc = "Spelling list";
    }
  ];
}
