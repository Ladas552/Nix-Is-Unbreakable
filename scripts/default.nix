{ config, pkgs, lib, ...}:
{
  environment.systemPackages = [
    (import ./rofi-wifi.nix { inherit pkgs lib; })
  ];
}
