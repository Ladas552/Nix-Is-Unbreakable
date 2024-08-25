{ config, lib, pkgs, ...}:
{
  options = {
    printers.enable = lib.mkEnableOption "enable printers";
  };

  config = lib.mkIf config.printers.enable {
    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
