{ home-manager,inputs,pkgs,config,lib, ... }:

{
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
