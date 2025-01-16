{
  pkgs,
  pkgs-stable,
  inputs,
  config,
  lib,
  meta,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  imports = [ ./../../homeModules ];

  customhm = {
    shell.enable = false;
    direnv.enable = true;
    gh.enable = true;
    ghostty.enable = true;
    helix.enable = true;
    yt-dlp.enable = true;
    nixvim.enable = false;
  };
  # Shell
  programs = {
    ripgrep.enable = true;
    fd.enable = true;
    btop.enable = true;
    bat.enable = true;
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    eza = {
      enable = true;
      enableFishIntegration = true;
      extraOptions = [ "--icons" ];
    };
  };

  # Shells
  programs.fish = {
    enable = true;
    plugins = with pkgs.fishPlugins; [
      {
        name = "autopair";
        src = autopair.src;
      }
      {
        name = "bass";
        src = bass.src;
      }
      {
        name = "pure";
        src = pure.src;
      }
      {
        name = "done";
        src = done.src;
      }
      {
        name = "puffer";
        src = puffer.src;
      }
      {
        name = "sponge";
        src = sponge.src;
      }
    ];
    shellAbbrs = {
      clean = "nh clean all";
      yy = "nh os switch ${meta.self}";
      yyy = "nh os switch -u ${meta.self}";
      eh = "hx ${meta.self}";
      v = "nvim";
      ls = "eza";
      mc = "ranger";
      mcc = "ranger ~/.config/";
    };
    shellAliases = { };
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };
  home.shellAliases = {
    cat = "${lib.getExe pkgs.bat}";
    df = "${lib.getExe pkgs.duf}";
    cmatrix = "${lib.getExe pkgs.unimatrix} -f -s 95";
    fastfetch = "fastfetch | ${lib.getExe pkgs.lolcat}";
    eh = "hx ${meta.self}";
    v = "nvim";
    ls = "eza";
    cd = "z";
    mc = "ranger";
    clean = "nh clean all";
    yy = "nh os switch ${meta.self}";
    yyy = "nh os switch -u ${meta.self}";
    n = "ssh-add ~/.ssh/NixToks";
  };
  # Me
  home.username = "${meta.user}";
  home.homeDirectory = "/home/${meta.user}";
  # Don't change
  home.stateVersion = "24.05"; # Please read the comment before changing.
  # Standalone Packages for user
  home.packages = with pkgs; [
    #pkgs-stable
    inputs.ghostty.packages.x86_64-linux.default
    libqalculate
    manix
    typst
  ];
  # Environment and Dependencies
  xdg = {
    enable = true;
  };

  home.sessionVariables = lib.mkForce {
    EDITOR = "hx";
    VISUAL = "hx";
    SUDO_EDITOR = "hx";
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
