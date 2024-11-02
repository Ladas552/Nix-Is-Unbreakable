{
  home-manager,
  inputs,
  pkgs,
  config,
  lib,
  ...
}:

{
  nix.buildMachines = [
    {
      # https://wiki.nixos.org/wiki/Distributed_build#Modify_the_local_machine's_Nix_config_to_know_about_the_remote_machine.
      hostName = "NixToks";
      systems = [
        "aarch64-linux"
        "x86_64-linux"
      ];
      protocol = "ssh-ng";
      speedFactor = 2;
      supportedFeatures = [
        "nixos-test"
        "benchmark"
        "big-parallel"
        "kvm"
      ];
      mandatoryFeatures = [ ];
    }
  ];
  # Enables the above config
  nix.distributedBuilds = true;
  nix.settings = {
    builders-use-substitutes = true;
  };

  # imports = [
  #  inputs.home-manager.nixosModules.default
  # ];
  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05"; # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # Set your time zone
  #time.timeZone = "Europe/Berlin";

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
