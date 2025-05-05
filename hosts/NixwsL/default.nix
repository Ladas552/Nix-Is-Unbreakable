{
  config,
  pkgs,
  inputs,
  lib,
  meta,
  # meta ? {
  #   host = "NixwsL";
  #   norg = "~/Documents/Norg";
  #   self = "/home/ladas552/Nix-Is-Unbreakable";
  #   user = "ladas552";
  # },
  ...
}:

{
  imports = [
    ./../../nixosModules
    inputs.home-manager.nixosModules.default
    inputs.nixos-wsl.nixosModules.default
  ];
  _module.args = {
    meta = {
      host = "NixwsL";
      self = "/home/ladas552/Nix-Is-Unbreakable";
      user = "ladas552";
      system = "x86_64-linux";
      isTermux = false;
    };
  };
  #modules
  custom = {
    pipewire.enable = false;
    fonts.enable = true;
    zerotier.enable = true;
    stylix = {
      enable = false;
      catppuccin = false;
      oksolar-light = false;
    };

  };

  # WSL options
  wsl = {
    enable = true;
    defaultUser = "${meta.user}";
    startMenuLaunchers = true;
    tarball.configPath = "${meta.self}";
    usbip.enable = true;
    useWindowsDriver = true;
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit meta;
    };
    users."${meta.user}" = import ./home.nix;
    useUserPackages = true;
    useGlobalPkgs = true;
  };
  environment.systemPackages = with pkgs; [
    # whatever I couldn't install in Home Manager
    python3
    #      nvtopPackages.full # they need to update cuda for unstable to use it in home manager
    cachix
    gcc
    gnumake
    # custom.wpick
    # custom.nvf-full.neovim
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  nixpkgs.hostPlatform = "x86_64-linux";
}
