{ config, lib, ... }:

{
  options.custom = { general.enable = lib.mkEnableOption "enable general"; };

  config = lib.mkIf config.custom.general.enable {
    # Disable X11 prompt for Git. Changes work only after Reboot for some reason
    # Here is the issue: https://github.com/NixOS/nixpkgs/issues/24311
    programs.ssh.askPassword = "";
    # Optimize nix experience by removing cache and store garbage
    nix.settings.auto-optimise-store = true;
    nix.optimise.automatic = true;
    # Flakes
    nix.settings = { experimental-features = [ "nix-command" "flakes" ]; };
  };
}
