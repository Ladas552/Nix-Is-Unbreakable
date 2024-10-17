{ pkgs, lib, ... }:
{
  environment.systemPackages = [
    (import ./rofi-wifi.nix { inherit pkgs lib; })
    (import ./word-lookup.nix { inherit pkgs lib; })
    (import ./Subtitlenator.nix { inherit pkgs; })
    (import ./musnow.nix { inherit pkgs; })
    (import ./wpick.nix { inherit pkgs lib; })
    (import ./rofi-powermenu.nix { inherit pkgs; })
  ];
}
