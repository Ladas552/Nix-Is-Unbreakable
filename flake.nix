{
  description = "Ladas552 NixOS config";

  inputs = {
    # nixpkgs links
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-gimp.url = "github:nixos/nixpkgs/c88e4e90048eaeaadc0caec090fed4ce5cc62240";

    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    # Home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-on-droid = {
      url = "github:t184256/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    # Ghostty master branch
    # It started to build instead of downloading quite often
    # ghostty.url = "github:ghostty-org/ghostty";

    stylix.url = "github:danth/stylix";
    # Neovim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-rocks = {
      url = "github:Ladas552/nvim-rocks-config";
      flake = false;
    };

    # Niri
    niri.url = "github:sodiboo/niri-flake";

    # Secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Overlays
    # neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
    # emacs-overlay.url = "github:nix-community/emacs-overlay";
    helix-overlay.url = "github:helix-editor/helix";
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # for osu: https://github.com/NixOS/nixpkgs/issues/372135#issuecomment-2688708953
    nix-gaming.url = "github:fufexan/nix-gaming";

    # ghostty-shaders = {
    #   url = "github:hackr-sh/ghostty-shaders";
    #   flake = false;
    # };

  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-master,
      nixpkgs-gimp,
      home-manager,
      ...
    }@inputs:
    # this is only for pkgs-master because I don't know how to use nixpkgs.config for pkgs-master along for unstable pkgs, pkgs doesn't get imported btw
    let
      pkgs-master = import nixpkgs-master {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      pkgs-gimp = import nixpkgs-gimp {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        # My Lenovo 50-70y laptop with nvidia 860M
        NixToks = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs-master;
          };

          modules = [ ./hosts/NixToks ];
        };
        # My Acer Swift Go 14 with ryzen 7640U
        NixPort = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs-master pkgs-gimp;
          };

          modules = [
            ./hosts/NixPort
          ];
        };
        # NixOS WSL setup
        NixwsL = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs-master;
          };

          modules = [ ./hosts/NixwsL ];
        };
        # Nix VM for testing major config changes
        NixVM = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs pkgs-master;
          };

          modules = [ ./hosts/NixVM ];
        };
      };
      # My android phone/tablet for Termux
      nixOnDroidConfigurations = {
        NixMux = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
          extraSpecialArgs = {
            inherit inputs;
          };
          pkgs = import nixpkgs {
            system = "aarch64-linux";

            config.allowUnfree = true;
          };

          modules = [ ./hosts/NixMux ];
        };
      };
    };
}
