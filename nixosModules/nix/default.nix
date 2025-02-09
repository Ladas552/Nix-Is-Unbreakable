{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  options.custom = {
    nix.enable = lib.mkEnableOption "enable nix";
  };

  config = lib.mkIf config.custom.nix.enable {
    # Optimize nix experience by removing cache and store garbage
    nix.settings.auto-optimise-store = true;
    nix.optimise.automatic = true;
    # Set nixpath for nixd
    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    # Better Error messages
    nix.package = pkgs.nixVersions.latest;
    # I don't use channels
    programs.command-not-found.enable = false;
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
