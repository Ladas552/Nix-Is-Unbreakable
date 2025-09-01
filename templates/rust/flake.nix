{
  description = "cargo init, git add ./, cargo update. And then you can use nix run instead of cargo run";
  inputs = {
    naersk = {
      url = "github:nix-community/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
  };
  outputs =
    {
      self,
      naersk,
      fenix,
      flake-utils,
      nixpkgs,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        target = "x86_64-unknown-linux-gnu";
        fenixLib = fenix.packages.${system};
        rustToolchain = fenixLib.latest.toolchain;
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        packages.default =
          (naersk.lib.${system}.override {
            cargo = rustToolchain;
            rustc = rustToolchain;
          }).buildPackage
            {
              src = ./.;
              CARGO_BUILD_TARGET = target;
            };

        devShells.default = pkgs.mkShell {
          nativeBuildInputs =
            with pkgs;
            [
              rustToolchain
              pkg-config
              gcc
              openssl
            ];
        };
      }
    );
}
