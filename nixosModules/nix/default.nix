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

  imports = [
    # it doesn't support `?shallow=1` that norgolith uses
    # inputs.lix-module.nixosModules.default
  ];

  config = lib.mkIf config.custom.nix.enable {

    # I don't use channels
    programs.command-not-found.enable = false;
    # Less building text
    documentation = {
      enable = true;
      doc.enable = false;
      man.enable = true;
      dev.enable = false;
    };
    # Nix options
    nix = {
      # Make builds run with low priority so my system stays responsive
      daemonCPUSchedPolicy = "idle";
      daemonIOSchedClass = "idle";
      # Better Error messages
      package = pkgs.nixVersions.latest;
      # Optimize nix experience by removing cache and store garbage
      optimise.automatic = true;
      # disable channels completely
      channel.enable = false;
      registry = (lib.mapAttrs (_: flake: { inherit flake; }) inputs);
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs;
      settings = {
        # Optimize nix experience by removing cache and store garbage
        auto-optimise-store = true;
        warn-dirty = false;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        nix-path = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs;
        flake-registry = ""; # optional, ensures flakes are truly self-contained
      };
    };
    # nixpkgs options
    nixpkgs.config = {
      allowUnfree = true;
    };
  };
}
