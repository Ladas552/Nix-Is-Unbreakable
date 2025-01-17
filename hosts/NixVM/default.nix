{
  config,
  pkgs,
  inputs,
  lib,
  pkgs-stable,
  meta,
  ...
}:

{
  imports = [
    ./../../nixosModules
    ./../../scripts
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];
  _module.args = {
    meta = {
      host = "NixVM";
      self = "/home/virtualboy/Nix-Is-Unbreakable";
      user = "virtualboy";
      system = "x86_64-linux";
      norg = "~/Documents/Norg";
      isTermux = false;
    };
  };
  # Stolen from Iynaix's VM config
  # Installing the appropriate guest utilities on a virtualised system
  # enable clipboard and file sharing
  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    spice-webdavd.enable = true;
  };
  # fix for spice-vdagentd not starting in wms
  systemd.user.services.spice-agent = {
    enable = true;
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${lib.getExe' pkgs.spice-vdagent "spice-vdagent"} -x";
    };
    unitConfig = {
      ConditionVirtualization = "vm";
      Description = "Spice guest session agent";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };
  };
  # Set nixpath for nixd
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  # Better Error messages
  nix.package = pkgs.nixVersions.latest;
  # Replace sh with dash for the meme by Greg
  environment.binsh = lib.getExe pkgs.dash;
  #modules
  custom = {
    niri.enable = true;
    openssh.enable = true;
    fonts.enable = true;
    pam.enable = true;
    stylix.enable = true;
    secrets.enable = true;
    zerotier.enable = false;
  };
  # For ZFS
  networking.hostId = "25a5vcvc";

  home-manager = {
    extraSpecialArgs = {
      inherit inputs pkgs-stable;
      inherit meta;
    };
    users."${meta.user}" = import ./home.nix;
    useUserPackages = true;
    useGlobalPkgs = true;
  };
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
  networking.hostName = "${meta.host}"; # Define your hostname.
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
    python3
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
  # Cache
  nix.settings = {
    trusted-users = [
      "root"
      "${meta.user}"
      "@wheel"
    ];
    substituters = [
      "https://ghostty.cachix.org/"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
    ];
    extra-substituters = [
      "https://cache.garnix.io"
      "https://niri.cachix.org"
      "https://devenv.cachix.org"
      "https://helix.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${meta.user} = {
    isNormalUser = true;
    description = "VirtualBoy";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPasswordFile = config.sops.secrets."mystuff/host_pwd".path;
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
  system.stateVersion = "24.11"; # Did you read the comment?

  #  _____ _____ ____ _____ ___ _   _  ____   __________ ____     ___  _   _   _   _ _____  __ __     ____  __
  # |_   _| ____/ ___|_   _|_ _| \ | |/ ___| |__  /  ___/ ___|   / _ \| \ | | | \ | |_ _\ \/ / \ \   / /  \/  |
  #   | | |  _| \___ \ | |  | ||  \| | |  _    / /| |_  \___ \  | | | |  \| | |  \| || | \  /   \ \ / /| |\/| |
  #   | | | |___ ___) || |  | || |\  | |_| |  / /_|  _|  ___) | | |_| | |\  | | |\  || | /  \    \ V / | |  | |
  #   |_| |_____|____/ |_| |___|_| \_|\____| /____|_|   |____/   \___/|_| \_| |_| \_|___/_/\_\    \_/  |_|  |_|

  # yes, don't go in here you rant

  boot = {
    supportedFilesystems.zfs = true;
    zfs = {
      devNodes = "/dev/disk/by-id";
    };
  };
  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
  };
  # standardized filesystem layo
  fileSystems = lib.mkDefault {
    "/" = {
      device = "zroot/root";
      fsType = "zfs";
      neededForBoot = true;
    };
    # boot partitin
    "/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };
    "/nix" = {
      device = "zroot/nix";
      fsType = "zfs";
    };
    # by default, /tmp is not a tmpfs on nixos as some build artifacts can be stored there
    # when using / as a small tmpfs for impermanence, /tmp can then easily run out of space,
    # so create a dataset for /tmp to prevent this
    # /tmp is cleared on boot via `boot.tmp.cleanOnBoot = true;
    "/tmp" = {
      device = "zroot/tmp";
      fsType = "zfs";
    };
    # cache are files that should be persisted, but not to snapshot
    # e.g. npm, cargo cache etc, that could always be redownload
    "/cache" = {
      device = "zroot/cache";
      fsType = "zfs";
      neededForBoot = true;
    };
  };
  # https://github.com/openzfs/zfs/issues/10891
  systemd.services = {
    systemd-udev-settle.enable = false;
  };
  services.sanoid = {
    enable = true;
    datasets = {
      "zroot/persist" = {
        hourly = 50;
        daily = 15;
        weekly = 3;
        monthly = 1;
      };
    };
  };

}
