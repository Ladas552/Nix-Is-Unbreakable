{
  inputs,
  pkgs,
  meta,
  lib,
  ...
}:

{
  _module.args = {
    meta = {
      host = "NixMux";
      self = "/data/data/com.termux.nix/files/home/Nix-Is-Unbreakable";
      user = "nix-on-droid";
      system = "aarch64-linux";
      norg = "~/storage/downloads/Norg";
      isTermux = true;
    };
  };
  # Thanks rix101 for the snippets
  # If you want to add new builders, also edit the `.config/nix/nix.conf` file
  # And add host to `.ssh/config` file
  nix.extraOptions = ''
          experimental-features = ${
            builtins.concatStringsSep " " [
              "nix-command"
              "flakes"
              "recursive-nix"
            ]
          }
    builders = ${
      # TODO: <https://nix.dev/manual/nix/2.18/advanced-topics/distributed-builds>
      builtins.concatStringsSep " ; " [
        "ssh-ng://NixToks                      x86_64-linux,aarch64-linux - 16 6 benchmark,big-parallel,kvm,nixos-test -"
        "ssh-ng://Zero                         x86_64-linux,aarch64-linux - 16 6 benchmark,big-parallel,kvm,nixos-test -"
      ]
    }
      builders-use-substitutes = true
      warn-dirty = false
  '';

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";
  # Set nixpath for nixd
  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; }) inputs);
  nix.nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs;
  # Better Error messages
  nix.package = pkgs.nixVersions.latest;
  # Read the changelog before changing this value
  system.stateVersion = "24.05"; # Set up nix for flakes
  # Set your time zone
  time.timeZone = "Asia/Almaty";
  # Termux settings
  android-integration = {
    termux-open.enable = true;
    termux-open-url.enable = true;
    xdg-open.enable = true;
    termux-reload-settings.enable = true;
    termux-setup-storage.enable = true;
  };
  # Greeter
  environment.motd = ''

    Welcome to nix-on-droid!

    * Rebuild system: yy
    * lf TUI file manager: mc
    * Edit config: en
    * Today's journal: j

  '';

  # To not build stuff but download
  nix.substituters = [
  ];
  nix.trustedPublicKeys = [
  ];

  # Theme
  terminal = {
    font =
      let
        jetbrains = pkgs.nerd-fonts.jetbrains-mono;
        fontPath = "share/fonts/truetype/NerdFonts/JetBrainsMono/JetBrainsMonoNerdFontMono-Regular.ttf";
      in
      "${jetbrains}/${fontPath}";
    colors = {
      cursor = "#F4DBD6";
      background = "#181B28";
      foreground = "#F8F8F2";
      color0 = "#000000"; # black
      color1 = "#ff5555"; # red
      color2 = "#50fa7b"; # green
      color3 = "#da00e9"; # highligh
      color4 = "#bd92f8"; # blue
      color5 = "#ff78c5"; # magenta
      color6 = "#8ae9fc"; # cyan
      color7 = "#bbbbbb"; # white
      color8 = "#545454"; # br black
      color9 = "#ff5454"; # br red
      color10 = "#50fa7b"; # br green
      color11 = "#f0fa8b"; # br yellow
      color12 = "#bd92f8"; # br blue
      color13 = "#ff78c5"; # br magenta
      color14 = "#8ae9fc"; # br cyan
      color15 = "#ffffff"; # br white
    };
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      inherit meta;
    };
    backupFileExtension = "hm-bak";
    config = import ./home.nix;
    useUserPackages = true;
    useGlobalPkgs = true;
  };
  user.shell = "${pkgs.fish}/bin/fish";
}
