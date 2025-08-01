{
  config,
  lib,
  meta,
  ...
}:

{
  options.custom = {
    incus.enable = lib.mkEnableOption "enable incus";
  };

  config = lib.mkIf config.custom.incus.enable {
    virtualisation.incus = {
      enable = true;
    };
    users.users.${meta.user}.extraGroups = [ "incus-admin" ];
  };
}
