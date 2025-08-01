{
  pkgs,
  inputs,
  meta,
  self,
  ...
}:
{

  # my nvf config
  nvf =
    (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ ./nvf ];
      extraSpecialArgs = {
        inherit meta;
      };
    }).neovim;
  # my nixvim config
  # <leader> keymaps don't work, idk why
  # if using blink.cmp it causes errors, idk why
  nixvim = (
    inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
      inherit pkgs;
      module = import ./nixvim;
      extraSpecialArgs = {
        inherit meta inputs;
      };
    }
  );
  default = pkgs.writeShellScriptBin "hello" ''echo "Hello World"'';
  restore = pkgs.callPackage ./restore.nix { };
  gcp = pkgs.callPackage ./addcommitpush.nix { };
  rofi-wifi = pkgs.callPackage ./rofi-wifi.nix { };
  word-lookup = pkgs.callPackage ./word-lookup.nix { };
  Subtitlenator = pkgs.callPackage ./Subtitlenator.nix { };
  musnow = pkgs.callPackage ./musnow.nix { };
  wpick = pkgs.callPackage ./wpick.nix { };
  rofi-powermenu = pkgs.callPackage ./rofi-powermenu.nix { inherit self; };
}
