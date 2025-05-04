{
  lib,
  pkgs,
  config,
  inputs,
  meta,
  ...
}:
# Stolen from @NTBBloodbath/tundra
{
  # custom option to modulry enable and disable neovim
  options.customhm = {
    neovim.enable = lib.mkEnableOption "enable neovim";
  };
  config = lib.mkIf config.customhm.neovim.enable {
    # so it knows where the header files are
    home.file.".local/share/nvim/rocks/luarocks-config.lua" = {
      enable = true;
      text = # lua
        ''
          lua_version = "5.1"

          rocks_trees = { {
              name = "rocks.nvim",
              root = "/home/${meta.user}/.local/share/nvim/rocks"
            } }

          variables = {
            LUA_INCDIR = "${pkgs.lua5_1}/include"
          }

          arch = "linux-x86_64"
        '';
    };
    # config for neovim
    home.file.".config/nvim" = {
      enable = true;
      recursive = true;
      source = inputs.neovim-rocks;
    };

    home.packages =
      with pkgs;
      [
        unzip # for rocks installation
      ]
      ++ lib.optionals meta.isTermux [ neovim-stable ]
      ++ lib.optionals (!meta.isTermux) [
        neovim-stable
        # neovim-nightly
      ];
    # environmental vatiables to not open nano
    home.sessionVariables = lib.mkDefault {
      EDITOR = "nvim";
      VISUAL = "nvim";
      SUDO_EDITOR = "nvim";
    };
  };
}
