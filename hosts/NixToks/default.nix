{
  config,
  pkgs,
  inputs,
  pkgs-master,
  meta,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../nixosModules
    ./../../scripts
    # Searchable hardware nodules with `nix repl` and command:
    # (builtins.getFlake ''/home/ladas552/Nix-Is-Unbreakable'').inputs.nixos-hardware.outputs.nixosModules
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
    # X11
    libinput.enable = true;
    xkb.enable = true;
    #   bspwm.enable = true;
    #lightdm.enable = true;
    # xfce.enable = true;
    # Wayland
    niri.enable = true;
    # wayfire.enable = true;
    # labwc.enable = true;
    # Network
    openssh.enable = true;
    bluetooth.enable = true;
    zerotier.enable = true;
    kde-connect.enable = true;
    #host services
    fonts.enable = true;
    games.enable = true;
    otd.enable = true;
    tlp.enable = true;
    #distrobox.enable = true;
    stylix.enable = true;
    # nix-ld.enable = true;
    printers.enable = true;
    # clamav.enable = true;
    # plymouth.enable = true;
    grub.enable = true;
    qemu.enable = true;
    zfs.enable = true;
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs pkgs-master;
      inherit meta;
    };
    users."${meta.user}" = import ./home.nix;
    useUserPackages = true;
    useGlobalPkgs = true;
  };
  # Latest kernel
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  # Enable networking
  networking.networkmanager.enable = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  environment.systemPackages = with pkgs; [
    # whatever I couldn't install in Home Manager
    python3
    #      nvtopPackages.full # they need to update cuda for unstable to use it in home manager
    cachix
    gcc
    gnumake
    networkmanagerapplet
  ];
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
  hardware.nvidia-container-toolkit.enable = config.custom.podman.enable;
  # This is the same thing but made harder. It was the firstier attempt and above ifs fixed one
  # hardware.nvidia-container-toolkit.enable = (lib.mkIf config.custom.docker.enable true);

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${meta.user} = {
    isNormalUser = true;
    description = "Ladas552";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    # hashedPasswordFile = config.sops.secrets."mystuff/host_pwd".path;
    #packages = with pkgs; [
    # firefox
    #  thunderbird
    #];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
