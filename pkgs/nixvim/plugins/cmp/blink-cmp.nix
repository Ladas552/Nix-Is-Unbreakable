{ ... }:
{
  performance.combinePlugins.standalonePlugins = [ "blink.cmp" ];
  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap = {
        preset = "enter";
        "<Tab>" = [
          "select_next"
          "fallback"
        ];
        "<S-Tab>" = [
          "select_prev"
          "accept"
          "fallback"
        ];
      };
      signature = {
        enabled = true;
        window.border = "rounded";
      };
      completion = {
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 1000;
          window.border = "rounded";
        };
        list.selection = {
          preselect = false;
          auto_insert = true;
        };
        menu = {
          border = "single";
          draw.columns = {
            # idk how to set it up
            # { "label",     "label_description", gap = 1 },
            # { "kind_icon", "kind" },
          };
        };
        ghost_text.enabled = true;
        keyword.range = "prefix"; # can also be `full`
      };
      sources = {
        providers = {
          buffer.score_offset = -7;
        };
        default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
        ];
      };
    };
  };

}
