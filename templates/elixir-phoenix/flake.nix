{
  description = "Phoenix flake";
  # The whole flake is a mess
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    flake-utils.url = "github:numtide/flake-utils?shallow=1";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      rec {
        # nix build
        packages.default = { };

        # nix run
        apps.default = flake-utils.lib.mkApp { drv = packages.default; };

        # nix develop
        devShells.default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
          ];
          buildInputs =
            with pkgs;
            [
              # elixir dependencies
              elixir
              elixir_ls # elixir lsp
              # erlang
              erlang_27
              erlang-ls # erlang lsp
              rebar3 # erlang built tool
              # database
              sqlite
            ]
            ++ lib.optionals stdenv.isLinux [
              # For ExUnit Notifier on Linux.
              libnotify

              # For file_system on Linux.
              inotify-tools
            ]
            ++ lib.optionals stdenv.isDarwin ([
              # For ExUnit Notifier on macOS.
              terminal-notifier

              # For file_system on macOS.
              darwin.apple_sdk.frameworks.CoreFoundation
              darwin.apple_sdk.frameworks.CoreServices
            ]);
          shellHook = ''
            # allows mix to work on the local directory
            mkdir -p .nix-mix
            mkdir -p .nix-hex
            export MIX_HOME=$PWD/.nix-mix
            export HEX_HOME=$PWD/.nix-hex
            export ERL_LIBS=$HEX_HOME/lib/erlang/lib

            # concats PATH
            export PATH=$MIX_HOME/bin:$PATH
            export PATH=$MIX_HOME/escripts:$PATH
            export PATH=$HEX_HOME/bin:$PATH

            # enables history for IEx
            export ERL_AFLAGS="-kernel shell_history enabled -kernel shell_history_path '\"$PWD/.erlang-history\"'"
          '';
        };
      }
    );
}
