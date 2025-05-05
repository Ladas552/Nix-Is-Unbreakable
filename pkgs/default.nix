{
  pkgs,
  inputs,
  meta,
  ...
}:
{

  # neovim config via nvf
  # neovim-iynaix =
  #   (inputs.nvf.lib.neovimConfiguration {
  #     inherit pkgs;
  #     modules = [ ./neovim-iynaix ];
  #     extraSpecialArgs = {
  #       dots = null;
  #     };
  #   }).neovim;

  # full neovim with nixd setup (requires path to dotfiles repo)
  nvf-full =
    (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;
      modules = [ ./nvf ];
      extraSpecialArgs = {
        inherit meta;
      };
    }).neovim;
  default = pkgs.writeShellScriptBin "hello" ''echo "Hello World"'';
  rofi-wifi = pkgs.callPackage ./rofi-wifi.nix { };
  word-lookup = pkgs.callPackage ./word-lookup.nix { };
  Subtitlenator = pkgs.callPackage ./Subtitlenator.nix { };
  musnow = pkgs.callPackage ./musnow.nix { };
  wpick = pkgs.callPackage ./wpick.nix { };
  rofi-powermenu = pkgs.callPackage ./rofi-powermenu.nix { };
}
