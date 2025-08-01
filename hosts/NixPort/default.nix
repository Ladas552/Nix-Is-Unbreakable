{
  pkgs,
  inputs,
  meta,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./../../nixosModules
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
    inputs.home-manager.nixosModules.default
  ];
  _module.args = {
    meta = {
      host = "NixPort";
      self = "/home/ladas552/Nix-Is-Unbreakable";
      user = "ladas552";
      system = "x86_64-linux";
      norg = "~/Documents/Norg";
      isTermux = false;
    };
  };
  # ZFS needs it
  networking.hostId = "f6d40058";
  #modules
  custom = {
    niri.enable = true;
    # bspwm.enable = true;
    # cage.ghostty.enable = true;
    # labwc.enable = true;
    # cage.cagebreak.enable = true;
    openssh.enable = true;
    # distrobox.enable = true;
    bluetooth.enable = true;
    kde-connect.enable = true;
    # games.enable = true;
    fonts.enable = true;
    otd.enable = true;
    printers.enable = true;
    tlp.enable = true;
    plymouth.enable = true;
    stylix = {
      enable = true;
      catppuccin = true;
      oksolar-light = false;
    };
    # grub.enable = true;
    systemd-boot.enable = true;
    xkb.enable = true;
    zerotier.enable = true;
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
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;


  # https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14s_(AMD)_Gen_3#Display
  boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" ];

  # Linux sheduler, works post 6.12
  # services.scx = {
  #   enable = true;
  #   package = pkgs.scx.rustscheds;
  # };
  # IT seems to stutter and restart sometimes, breaking my desktop IO devices

  # Enable networking
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    # whatever I couldn't install in Home Manager
    python314
    cachix
    gcc
    gnumake
    networkmanagerapplet
    # Launchers
    # PC games
    osu-lazer-bin
    # stepmania
    openmw
    daggerfall-unity
    mindustry
    luanti
    # Utilities
    # xclicker
    # Dependencies
    steam-run
    # Emulators
    duckstation
    blastem
    mgba
    snes9x-gtk
    punes
    melonDS
    # doesn't work       retroarchFull
    # too complex and need a special controller      mame

  ];
  # Radeon
  # Enable OpenGL and hardware accelerated graphics drivers
  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      vpl-gpu-rt
    ];
  };
  # Enable rocm
  nixpkgs.config.rocmSupport = true;
  hardware.amdgpu = {
    opencl.enable = true;
    initrd.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${meta.user} = {
    isNormalUser = true;
    description = "Ladas552";
    extraGroups = [
      "networkmanager"
      "wheel"
      # for adb
      # "adbusers"
    ];
    password = "4558";
    # hashedPasswordFile = config.sops.secrets."mystuff/host_pwd".path;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  # Testing nix-on-droid in waydroid
  # virtualisation.waydroid.enable = true;
  # programs.adb.enable = true;
}
