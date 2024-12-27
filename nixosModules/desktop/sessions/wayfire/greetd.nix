{ pkgs, user, ... }:
{
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "${user}";
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.wayfire}/bin/wayfire";
        user = "${user}";
      };
      default_session = initial_session;
    };
  };
}
