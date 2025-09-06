# {
#   lib,
#   config,
# pkgs,
#   meta,
#   inputs,
#   ...
# }:
{
  imports = [
    # Neorg module only for overlay. Don't forget to reenable overlay in flake.nix
    # ./config/neorg-overlay.nix
    ./config/autocmd.nix
    ./config/option.nix
    ./config/keymaps.nix
    ./config/neorg.nix
    ./config/full-plugins.nix
    ./config/mobile-plugins.nix
    ./config/colorscheme.nix
  ];
  enableMan = false;
  clipboard.providers.wl-copy.enable = true;
  # I want to make it copy on keybind, but `+y` doesn't work for me, so this will do
  clipboard.register = "unnamedplus";
  # package = lib.mkIf (
  #   meta.system == "x86_64-linux"
  # ) inputs.neovim-nightly-overlay.packages.x86_64-linux.default;
  withRuby = false;
  # Performance
  luaLoader.enable = true;
  performance = {
    byteCompileLua = {
      enable = true;
      nvimRuntime = true;
      plugins = true;
    };
  };
  dependencies = {
    git.enable = true;
    curl.enable = true;
  };
}
