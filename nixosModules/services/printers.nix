{ config, lib, pkgs, ... }: {
  options.custom = { printers.enable = lib.mkEnableOption "enable printers"; };

  config = lib.mkIf config.custom.printers.enable {
    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
