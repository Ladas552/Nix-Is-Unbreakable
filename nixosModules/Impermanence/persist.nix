{
  config,
  lib,
  ...
}:
# This file exists to not clutter other nixos module files with generic persists, like network manager. I will move all options below somewhere else before I finish impermanence setup
{
  config = lib.mkIf config.custom.imp.enable {
    custom.imp = {
      root = {
        directories =
          [ ]
          ++ lib.optionals config.networking.networkmanager.enable [
            "/etc/NetworkManager/"
            "/var/lib/NetworkManager"
            "/var/lib/iwd"
          ];
      };
      home = {
        directories = [
          ".librewolf"
        ];
        cache = {
          directories = [
            ".local/share/Trash"
            ".local/share/qalculate"
            ".local/share/TelegramDesktop"
            ".local/share/nvim"
            ".local/state/nvim"
            ".local/state/nvf"
            ".config/libreoffice"
            ".cache/librewolf"
            ".cache/keepassxc"
            ".config/keepassxc"
          ];
        };
      };
    };
  };
}
