{ lib, config, ... }:

{
  options.customhm = {
    fastfetch.enable = lib.mkEnableOption "enable fastfetch";
  };

  config = lib.mkIf config.customhm.fastfetch.enable {
    programs.fastfetch = {
      enable = true;
      # modified 21st example from fastfetch in nix code
      settings = {
        logo.source = "nixos_old_small";
        display = {
          constants = [ "██ " ];
        };
        modules = [
          {
            key = "{$1}Distro";
            keyColor = "38;5;210";
            type = "os";
          }
          {
            key = "{$1}Kernel";
            keyColor = "38;5;84";
            type = "kernel";
          }
          {
            key = "{$1}Shell";
            keyColor = "38;5;147";
            type = "shell";
          }
          {
            key = "{$1}Packages";
            keyColor = "38;5;200";
            type = "packages";
          }
          {
            key = "{$1}WM";
            keyColor = "38;5;44";
            type = "wm";
          }
          {
            key = "{$1}CPU";
            keyColor = "38;5;75";
            type = "cpu";
          }
          {
            key = "{$1}GPU";
            keyColor = "38;5;123";
            type = "gpu";
          }
        ];
      };
    };
  };
}
