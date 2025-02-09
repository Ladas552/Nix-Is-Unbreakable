{ lib, config, ... }:
{
  options.custom = {
    grub.enable = lib.mkEnableOption "enable grub";
  };
  config = lib.mkIf config.custom.grub.enable {
    # GRUB Bootloader
    boot = {
      initrd.systemd.enable = true;
      supportedFilesystems.ntfs = true;
      loader = {
        grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
          useOSProber = true;
          timeoutStyle = "hidden";
          gfxmodeEfi = "1920x1080";
          gfxmodeBios = "1920x1080";
        };
        efi = {
          efiSysMountPoint = "/boot";
          canTouchEfiVariables = true;
        };
      };
    };
  };
}
