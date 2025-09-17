{
  config,
  lib,
  ...
}:

{
  options.custom = {
    imp.enable = lib.mkEnableOption "enable impermanence";
  };
  imports = [ ./users.nix ];
  config = lib.mkIf config.custom.imp.enable { };
}
