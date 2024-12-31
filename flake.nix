{
  description = "NixToks NixOS config";

  inputs = {
    # nixpkgs links
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.11";

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

    # Ghostty, yeap
    ghostty.url = "github:ghostty-org/ghostty";

    stylix.url = "github:danth/stylix";
    # Neovim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
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
    # i don't like compiling rust
    helix-overlay.url = "github:helix-editor/helix/ba6e6dc3dd96e3688bb7bb5d553adb5fcb005e34";

    hardware.url = "github:nixos/nixos-hardware";

    # Games
    # aagl = {
    #   url = "github:ezKEa/aagl-gtk-on-nix";
    #   inputs.nixpkgs.follows = "nixpkgs"; # Name of nixpkgs input you want to use
    # };
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      ...
    }@inputs:
    let
      # why pkgs-stable works? here https://discourse.nixos.org/t/allow-unfree-in-flakes/29904/2
      pkgs-stable = import nixpkgs-stable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        NixToks = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit pkgs-stable;
            inherit pkgs;
            host = "NixToks";
            self = "/home/ladas552/Nix-dots";
            user = "ladas552";
            system = "x86_64-linux";
          };

          modules = [ ./hosts/NixToks ];
        };

        NixFlash = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            host = "NixFlash";
            user = "Fixer";
            system = "x86_64-linux";
          };

          modules = [ ./hosts/NixFlash ];
        };
      };

      nixOnDroidConfigurations = {
        NixMux = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
          extraSpecialArgs = {
            inherit inputs;
            host = "NixMux";
            self = "/data/data/com.termux.nix/files/home/Nix-Is-Unbreakable";
            user = "nix-on-droid";
            system = "aarch64-linux";
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
