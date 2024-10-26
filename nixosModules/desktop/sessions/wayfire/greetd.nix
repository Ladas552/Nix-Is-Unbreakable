{ pkgs, ... }:
{
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "ladas552";
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.wayfire}/bin/wayfire";
        user = "ladas552";
      };
      default_session = initial_session;
    };
  };
}
