{
  description = "NixToks NixOS config";

  inputs = {
    # nixpkgs links
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.05";

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
    ghostty.url = "git+ssh://git@github.com/ghostty-org/ghostty";

    stylix.url = "github:danth/stylix";
    # Neovim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Overlays
    # neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
    # emacs-overlay.url = "github:nix-community/emacs-overlay";
    helix-overlay.url = "github:helix-editor/helix";

    hardware.url = "github:nixos/nixos-hardware";

    # Games
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs"; # Name of nixpkgs input you want to use
    };
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
      system = "x86_64-linux";
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
            inherit system;
            inherit inputs;
            inherit pkgs-stable;
            inherit pkgs;
          };

          modules = [ ./hosts/NixToks ];
        };

        NixFlash = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit inputs;
          };

          modules = [ ./hosts/NixFlash ];
        };
      };

      nixOnDroidConfigurations = {
	      NixMux = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
		      extraSpecialArgs = {inherit inputs;};
		      pkgs = import nixpkgs { system = "aarch64-linux"; };
		      modules = [ ./hosts/NixMux ];
        };
      };
    };
}
