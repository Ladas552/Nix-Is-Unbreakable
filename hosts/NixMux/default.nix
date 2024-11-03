{
  home-manager,
  inputs,
  pkgs,
  config,
  lib,
  ...
}:

{
  # Thanks rix101 for the snippet
  nix.extraOptions = ''
          experimental-features = ${
            builtins.concatStringsSep " " [
              "nix-command"
              "flakes"
              "recursive-nix"
            ]
          }
    builders = ${
      # TODO: <https://nix.dev/manual/nix/2.18/advanced-topics/distributed-builds>
      builtins.concatStringsSep " ; " [
        "ssh-ng://NixToks                      x86_64-linux,aarch64-linux - 16 6 benchmark,big-parallel,kvm,nixos-test -"
      ]
    }
      builders-use-substitutes = true
  '';

  # imports = [
  #  inputs.home-manager.nixosModules.default
  # ];
  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Set nixpath for nixd
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  # Better Error messages
  nix.package = pkgs.nixVersions.latest;
  # Read the changelog before changing this value
  system.stateVersion = "24.05"; # Set up nix for flakes
  # Set your time zone
  time.timeZone = "Asia/Almaty";

   home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    backupFileExtension = "hm-bak";
    config = import ./home.nix;
    useUserPackages = true;
    #useGlobalPkgs = true;
  };
}
