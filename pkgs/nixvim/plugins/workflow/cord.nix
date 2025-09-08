{ meta, lib, ... }:
{
  plugins.cord = lib.mkIf (meta.host != "") {
    # enable = true;
    settings = {
      editor = {
        client = "1375074497681690665";
        tooltip = "Nix flavored Neovim";
        icon = "nixvim_logo";
      };
      display = {
        theme = "catppuccin";
        flavor = "accent";
      };
      text = {
        default = "Editing in Neovim";
        workspace = "Moving Blazingly Fast";
        viewing = "Viewing in Neovim";
        docs = "RTFMing";
        vcs = "Solving git conflicts";
        notes = "Norging it";
        dashboard = "In ~";
      };
    };
  };
}
