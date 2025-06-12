{
  pkgs,
  inputs,
  meta,
  lib,
  config,
  modulesPath,
  ...
}:
# build the image with
# nix run nixpkgs#nixos-generators -- --format iso --flake "github:Nix-Is-Unbreakable#NixIso" -o result
{
  imports = [
    # Include the results of the hardware scan.
    ./../../nixosModules
    ./../../scripts
    inputs.home-manager.nixosModules.default
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];
  _module.args = {
    meta = {
      host = "NixIso";
      self = "github:Ladas552/Nix-Is-Unbreakable";
      norg = null;
      user = "nixos";
      system = "x86_64-linux";
      isTermux = false;
    };
  };
  nixpkgs.hostPlatform = "x86_64-linux";
  services.openssh.settings.PermitRootLogin = lib.mkForce "yes";
  #modules
  custom = {
    niri.enable = true;
    # cage.ghostty.enable = true;
    # cage.cagebreak.enable = true;
    openssh.enable = true;
    bluetooth.enable = true;
    # games.enable = true;
    fonts.enable = true;
    tlp.enable = true;
    stylix = {
      enable = true;
      catppuccin = true;
      oksolar-light = false;
    };
    systemd-boot.enable = true;
    xkb.enable = true;
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit meta;
    };
    users."${meta.user}" = import ./home.nix;
    useUserPackages = true;
    useGlobalPkgs = false;
  };
  # Xanmod kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.wireless.enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    gparted
    networkmanagerapplet
    # Calamares for graphical installation
    libsForQt5.kpmcore
    calamares-nixos
    calamares-nixos-extensions
    # Get list of locales
    glibcLocales
  ];
  # Seg faults the iso build
  # i18n.supportedLocales = lib.mkForce [ "all" ];

  # graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # specialisation.AMD-GPU.configuration = {
  #   # Radeon
  #   # Enable OpenGL and hardware accelerated graphics drivers
  #   services.xserver.videoDrivers = [ "modesetting" ];

  #   hardware.amdgpu = {
  #     opencl.enable = true;
  #     initrd.enable = true;
  #   };
  #   # https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14s_(AMD)_Gen_3#Display
  #   boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" ];
  # };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${meta.user} = {
    isNormalUser = true;
    description = "nixos";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
