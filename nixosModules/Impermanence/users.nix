{
  meta,
  config,
  lib,
  ...
}:
{
  # setup immutable users for impermanence

  # silence warning about setting multiple user password options
  # https://github.com/NixOS/nixpkgs/pull/287506#issuecomment-1950958990
  # Stolen from Iynaix https://github.com/iynaix/dotfiles/blob/4880969e7797451f4adc3475cf33f33cc3ceb86e/nixos/users.nix#L18-L24
  options = {
    warnings = lib.mkOption {
      apply = lib.filter (
        w: !(lib.hasInfix "If multiple of these password options are set at the same time" w)
      );
    };
  };
  config = {
    users.mutableUsers = false;
    users.users = {
      ${meta.user} = {
        isNormalUser = true;
        description = "Ladas552";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        initialPassword = "pass";
        hashedPasswordFile = config.sops.secrets."mystuff/host_pwd".path;
      };
      root = {
        initialPassword = "pass";
        hashedPasswordFile = config.sops.secrets."mystuff/host_pwd".path;
      };
    };
  };
}
