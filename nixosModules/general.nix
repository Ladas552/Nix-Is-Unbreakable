{ config, lib, ... }:

{
  options.custom = {
    general.enable = lib.mkEnableOption "enable general";
  };

  config = lib.mkIf config.custom.general.enable {
    # Disable X11 prompt for Git. Changes work only after Reboot for some reason
    # Here is the issue: https://github.com/NixOS/nixpkgs/issues/24311
    programs.ssh.askPassword = "";
    # Optimize nix experience by removing cache and store garbage
    nix.settings.auto-optimise-store = true;
    nix.optimise.automatic = true;
    # Less building text
    documentation = {
      enable = true;
      doc.enable = false;
      man.enable = true;
      dev.enable = false;
    };
    # Make builds run with low priority so my system stays responsive
    nix.daemonCPUSchedPolicy = "idle";
    nix.daemonIOSchedClass = "idle";
    # Flakes
    nix.settings = {
      warn-dirty = false;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    # nixpkgs options
    nixpkgs.config = {
      allowUnfree = true;
    };
  };
}
