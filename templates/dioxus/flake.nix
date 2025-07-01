{
  description = "Experimental norg gui in dioxus";
  # The whole flake is a mess
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable&shallow=1";
    flake-utils.url = "github:numtide/flake-utils?shallow=1";
    rust-overlay = {
      url = "github:oxalica/rust-overlay?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      rust-overlay,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        toolchain = pkgs.rustPlatform;
        cargoPackage = (pkgs.lib.importTOML "${self}/Cargo.toml").package;
      in
      rec {
        # nix build
        packages.default = toolchain.buildRustPackage {
          pname = cargoPackage.name;
          version = cargoPackage.version;
          src = pkgs.lib.cleanSource "${self}";
          cargoLock = {
            lockFile = "${self}/Cargo.lock";
            allowBuiltinFetchGit = true;
          };
          useNextest = true;
          dontUseCargoParallelTests = true;

          nativeBuildInputs = with pkgs; [
            pkg-config
          ];
          buildInputs = with pkgs; [
            openssl
          ];
          PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";

          meta = {
            description = cargoPackage.description;
            homepage = cargoPackage.repository;
            license = pkgs.lib.licenses.gpl2Only;
            maintainers = cargoPackage.authors;
          };

          # For other makeRustPlatform features see:
          # https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/rust.section.md#cargo-features-cargo-features
        };

        # nix run
        apps.default = flake-utils.lib.mkApp { drv = packages.default; };

        # nix develop
        devShells.default = pkgs.mkShell {
          nativeBuildInputs =
            with pkgs;

            [
              pkg-config
              gcc
              openssl
              rustPlatform.bindgenHook
              nodePackages.tailwindcss
            ];
          buildInputs =
            with pkgs;
            let
              rustBuildInputs =
                [
                  pkgs.openssl
                  pkgs.libiconv
                  pkgs.pkg-config
                ]
                ++ pkgs.lib.optionals pkgs.stdenv.isLinux [
                  pkgs.glib
                  pkgs.gtk3
                  pkgs.libsoup_3
                  pkgs.webkitgtk_4_1
                  pkgs.xdotool
                  pkgs.cairo
                  pkgs.gdk-pixbuf
                  pkgs.gobject-introspection
                  pkgs.atkmm
                  pkgs.pango
                ]
                ++ pkgs.lib.optionals pkgs.stdenv.isDarwin (
                  with pkgs.darwin.apple_sdk.frameworks;
                  [
                    IOKit
                    Carbon
                    WebKit
                    Security
                    Cocoa
                  ]
                );
            in
            [
              (pkgs.rust-bin.stable.latest.default.override {
                targets = [
                  "wasm32-unknown-unknown"
                  "x86_64-unknown-linux-gnu"
                ];
              })
              # https://github.com/rust-lang/rust-analyzer/issues/18090
              # rust-bin.stable.latest.rust-analyzer
              rustBuildInputs
              cargo-edit
              cargo-nextest
              openssl
              # Dioxus dependency
              dioxus-cli
              lld
              wasm-bindgen-cli_0_2_100
              # Dioxus libraries

            ];

          # Many editors rely on this rust-src PATH variable
          RUST_SRC_PATH = "${toolchain.rustLibSrc}";

          PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
        };
      }
    );
}
