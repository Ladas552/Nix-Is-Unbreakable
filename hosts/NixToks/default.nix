{
  config,
  pkgs,
  inputs,
  meta,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../nixosModules
    # enable trimming
    inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
    inputs.home-manager.nixosModules.default
  ];
  _module.args = {
    meta = {
      host = "NixToks";
      self = "/home/ladas552/Nix-Is-Unbreakable";
      user = "ladas552";
      system = "x86_64-linux";
      norg = "~/Documents/Norg";
      isTermux = false;
    };
  };
  # Needed for ZFS, generated from command:
  # head -c 8 /etc/machine-id
  networking.hostId = "98d7caca";

  #build machine for termux
  # Termux builder
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  #modules
  custom = {
    # Services
    deluge.enable = true;
    homepage-dashboard.enable = true;
    immich.enable = true;
    jellyfin.enable = true;
    kavita.enable = true;
    miniflux.enable = true;
    nextcloud.enable = true;
    radarr.enable = true;
    sonarr.enable = true;
    # ncps.enable = true;
    xkb.enable = true;
    greetd.enable = false;
    # nix-ld.enable = true;
    # Network
    openssh.enable = true;
    zerotier.enable = true;
    # Host services
    fonts.enable = true;
    tlp.enable = true;
    # Virtualisation
    # incus.enable = true;
    distrobox.enable = true;
    qemu.enable = true;
    # Eye candy
    plymouth.enable = true;
    stylix = {
      enable = true;
      catppuccin = true;
      oksolar-light = false;
    };
    # Essential for boot
    grub.enable = true;
    zfs.enable = true;
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

  # Xanmod kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;

  # Linux sheduler, works post 6.12
  # services.scx = {
  #   enable = true;
  #   package = pkgs.scx.rustscheds;
  # };

  # Networking
  # NixToks wifi card is dead
  networking.networkmanager.enable = false;

  # Nvidia
  # Enable OpenGL and hardware accelerated graphics drivers

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      intel-media-driver
      intel-ocl
      vpl-gpu-rt
    ];
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ]; # or "nvidiaLegacy470 etc.
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
  # Enable cuda. Needs building
  nixpkgs.config.cudaSupport = true;
  # Environmental variable for Wayland and stuff
  environment.variables = {
    __NV_PRIME_RENDER_OFFLOAD = 1;
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
  };
  # IF statement to enable vitalization for Nvidia in Docker. If Docker module is disabled it returns false, if enabled returns true
  hardware.nvidia-container-toolkit.enable = config.virtualisation.podman.enable;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${meta.user} = {
    isNormalUser = true;
    description = "Ladas552";
    extraGroups = [
      "wheel"
      "deluge"
      "immich"
      "kavita"
      "radarr"
      "sonarr"
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  ## Powermanagment
  ## It disabled usb after some time of incativity, so not usable on desktop

  powerManagement.powertop.enable = true;

  ## Turn of screen and don't go to sleep

  services.logind = {
    lidSwitchExternalPower = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitch = "ignore";
  };

  ##### ZFS MOUNT POINTS
  ##### Because I have additional drive for NixToks
  fileSystems."/mnt/zmedia" = {
    device = "zmedia/files";
    fsType = "zfs";
  };

}
