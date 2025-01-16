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
  # Set nixpath for nixd
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  # Better Error messages
  nix.package = pkgs.nixVersions.latest;
  # Replace sh with dash for the meme by Greg
  environment.binsh = lib.getExe pkgs.dash;
  #modules
  custom = {
    sounds.enable = false;
    secrets.enable = false;
    zerotier.enable = false;
    fonts.enable = true;
    stylix.enable = false;
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

  nixpkgs.hostPlatform = "${meta.system}";

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
  networking.hostName = "${meta.host}"; # Define your hostname.

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
  # Cache
  nix.settings = {
    trusted-users = [
      "root"
      "${meta.user}"
      "@wheel"
    ];
    substituters = [
      "https://ezkea.cachix.org"
      "https://ghostty.cachix.org/"
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
      "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
    ];
    extra-substituters = [
      "https://cache.garnix.io"
      "https://devenv.cachix.org"
      "https://helix.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
