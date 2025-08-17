{
  description = "Ladas552 NixOS config";

  inputs = {
    # nixpkgs links
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-immich.url = "github:nixos/nixpkgs/00a0f9248929557d03b7fdb04b4aa3e04980ebc7";

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

    stylix.url = "github:nix-community/stylix";
    # Neovim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-rocks = {
      url = "github:Ladas552/nvim-rocks-config";
      flake = false;
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # blink-cmp = {
    #   url = "github:Saghen/blink.cmp";
    # };

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

    # ghostty.url = "github:ghostty-org/ghostty";
    # ghostty-shaders = {
    #   url = "github:hackr-sh/ghostty-shaders";
    #   flake = false;
    # };
    # ghostty-cursor = {
    #   url = "github:KroneCorylus/shader-playground";
    #   flake = false;
    # };

  };

  outputs =
    {
      nixpkgs,
      self,
      ...
    }@inputs:
    let
      meta = {
        isTermux = false;
        host = "";
        norg = null;
        self = "";
        user = "ladas552";
      };
      lib = inputs.nixpkgs.lib;
      supportedSystems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      forSystems = nixpkgs.lib.genAttrs supportedSystems;

      nixpkgsFor = forSystems (
        system:
        import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
      createCommonArgs = system: {
        inherit
          self
          inputs
          nixpkgs
          lib
          meta
          ;
        pkgs = nixpkgsFor.${system};
        specialArgs = {
          inherit self inputs meta;
        };
      };
      # call with forAllSystems (commonArgs: function body)
      forAllSystems =
        fn:
        lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ] (system: fn (createCommonArgs system));
    in

    {
      nixosConfigurations = {
        # My Lenovo 50-70y laptop with nvidia 860M
        NixToks = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs self;
          };

          modules = [
            ./hosts/NixToks
            ./overlays
          ];
        };
        # My Acer Swift Go 14 with ryzen 7640U
        NixPort = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs self;
          };

          modules = [
            ./hosts/NixPort
            ./overlays
          ];
        };
        # NixOS WSL setup
        NixwsL = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs self;
          };

          modules = [
            ./hosts/NixwsL
            ./overlays
          ];
        };
        # Nix VM for testing major config changes
        NixVM = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs self;
          };

          modules = [
            ./hosts/NixVM
            ./overlays
          ];
        };
        # Nix Iso for live cd
        NixIso = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs self;
          };

          modules = [
            ./hosts/NixIso
            ./overlays
          ];
        };
      };
      # My android phone/tablet for Termux
      nixOnDroidConfigurations =
        let
          meta = {
            isTermux = true;
            host = "NixMux";
            self = "/data/data/com.termux.nix/files/home/Nix-Is-Unbreakable";
            norg = "~/storage/downloads/Norg";
            user = "ladas552";
          };
        in
        {
          NixMux = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
            extraSpecialArgs = {
              inherit inputs;
            };
            pkgs = import nixpkgs {
              system = "aarch64-linux";
              overlays = [
                (_: prev: {
                  custom =
                    (prev.custom or { })
                    // (import ./pkgs {
                      inherit (prev) pkgs;
                      inherit inputs meta self;
                    });
                })
              ];
              config.allowUnfree = true;
            };

            modules = [
              ./hosts/NixMux
            ];
          };
        };
      packages = forAllSystems (commonArgs': (import ./pkgs commonArgs'));
      # flake templates
      templates = import ./templates;
    };
}
