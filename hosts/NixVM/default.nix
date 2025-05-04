{
  config,
  pkgs,
  inputs,
  lib,
  meta,
  ...
}:

{
  imports = [
    ./../../nixosModules
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
  #modules
  custom = {
    niri.enable = true;
    openssh.enable = true;
    fonts.enable = true;
    secrets.enable = true;
    zerotier.enable = false;
    systemd-boot.enable = true;
  };
  # For ZFS
  networking.hostId = "cb82b8e4";

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit meta;
    };
    users."${meta.user}" = import ./home.nix;
    useUserPackages = true;
    useGlobalPkgs = true;
  };
  # Latest kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  # Enable networking
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    python3
    cachix
    gcc
    gnumake
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${meta.user} = {
    isNormalUser = true;
    description = "VirtualBoy";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    # hashedPasswordFile = config.sops.secrets."mystuff/host_pwd".path;
  };

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
      devNodes = "/dev/disk/by-partuuid";
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
