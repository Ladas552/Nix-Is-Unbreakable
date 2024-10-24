{
  config,
  pkgs,
  inputs,
  pkgs-stable,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../nixosModules
    ./../../scripts
    inputs.home-manager.nixosModules.default
  ];
  # Set nixpath for nixd
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  # Better Error messages
  nix.package = pkgs.nixVersions.latest;
  #modules
  custom = {
    # X11
    libinput.enable = true;
    #   bspwm.enable = true;
    #lightdm.enable = true;
    # ly.enable = true;
    # xfce.enable = true;
    # Wayland
    niri.enable = true;
    # Network
    openssh.enable = true;
    bluetooth.enable = true;
    zerotier.enable = true;
    kde-connect.enable = true;
    #host services
    fonts.enable = true;
    games.enable = true;
    otd.enable = true;
    powermanager.enable = true;
    pam.enable = true;
    distrobox.enable = true;
    stylix.enable = true;
    # nix-ld.enable = true;
    # printers.enable = true;
    # clamav.enable = true;
    # plymouth.enable = true;
    # virtualisation.enable = true;
    # minecraft.enable = true; Don't need right now
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs pkgs-stable;
    };
    users."ladas552" = import ./home.nix;
    useUserPackages = true;
    #useGlobalPkgs = true;
  };
  #trim your SSD
  services.fstrim.enable = true;
  # Latest kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  # Bootloader.
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      timeoutStyle = "hidden";
      gfxmodeEfi = "1920x1080";
      gfxmodeBios = "1920x1080";
    };
    efi.efiSysMountPoint = "/boot";
    efi.canTouchEfiVariables = true;
  };
  networking.hostName = "NixToks"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Almaty";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  environment.systemPackages = with pkgs; [
    # whatever I couldn't install in Home Manager
    python3
    #      nvtopPackages.full # they need to update cuda for unstable to use it in home manager
    cachix
    gcc
    gnumake
    sops
  ];
  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us,kz";
    xkb.variant = "";
    xkb.options = "grp:caps_toggle";
    xkb.model = "pc105";
  };
  # Experiment stuff
  nix.settings = {
    trusted-users = [
      "root"
      "ladas552"
      "@wheel"
    ];
    substituters = [
      "https://ezkea.cachix.org"
      "https://ghostty.cachix.org/"
    ];
    trusted-public-keys = [
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
    ];
    extra-substituters = [
      "https://cache.garnix.io"
      "https://niri.cachix.org"
      "https://devenv.cachix.org"
      "https://helix.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
    ];
  };

  # Nvidia
  # Enable OpenGL and hardware accelerated graphics drivers

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      intel-media-driver
      intel-ocl
    ];
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ]; # or "nvidiaLegacy470 etc.
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      sync.enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
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
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ladas552 = {
    isNormalUser = true;
    description = "Ladas552";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPasswordFile = config.sops.secrets."mystuff/host_pwd".path;
    #packages = with pkgs; [
    # firefox
    #  thunderbird
    #];
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 9993 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
