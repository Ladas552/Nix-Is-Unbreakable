{ config, lib, pkgs, ...}:

{
  options = {
    nix-ld.enable = lib.mkEnableOption "enable nix-ld";
  };
  # Dynamically linked libraries, they generate paths for some programms to work properly, like app images. If you add new programm to create paths for, need to reboot
  config = lib.mkIf config.nix-ld.enable {

    programs.nix-ld.enable = true;

    programs.nix-ld.libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      fuse3
      icu
      nss
      openssl
      curl
      expat
      appimage-run
      cmake
      gnumake
      # ...
    ];
  };
}
