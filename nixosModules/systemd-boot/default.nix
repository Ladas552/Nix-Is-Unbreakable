{
  config,
  lib,
  pkgs,
  meta,
  ...
}:
{
  options.custom = {
    systemd-boot.enable = lib.mkEnableOption "enable systemd-boot";
  };

  config = lib.mkIf config.custom.systemd-boot.enable {
    boot = {
      initrd.systemd.enable = true;
      supportedFilesystems.ntfs = true;
      loader = {
        systemd-boot = {
          enable = true;
          consoleMode = "2";
          edk2-uefi-shell = {
            enable = true;
            sortKey = "x_edk2-uefi-shell";
          };
          windows = lib.mkIf (meta.host == "NixPort") {
            "11-home" = {
              title = "Windows 11 Home";
              efiDeviceHandle = "HD0b";
              sortKey = "z_windows";
            };
          };
          # no wait until boot, press `space` to get the menu
          extraInstallCommands = # sh
            ''
              ${lib.getExe' pkgs.gnused "sed"} -i '/timeout 5/c\timeout 0' /boot/loader/loader.conf
            '';
        };
        efi = {
          efiSysMountPoint = "/boot";
          canTouchEfiVariables = true;
        };
      };
    };
  };
}
