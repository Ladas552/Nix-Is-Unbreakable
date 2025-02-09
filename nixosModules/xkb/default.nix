{ config, lib, ... }:
{
  options.custom = {
    xkb.enable = lib.mkEnableOption "enable xkb";
  };

  config = lib.mkIf config.custom.xkb.enable {
    # Configure keymap in X11
    services.xserver = {
      xkb.layout = "us,kz";
      xkb.variant = "";
      xkb.options = "grp:caps_toggle";
      xkb.model = "pc105";
    };
  };
}
