{
  pkgs,
  lib,
  self,
  ...
}:
{
  imports = [ ./../../homeModules ];

  customhm = {
    helix.enable = true;
    nixvim = {
      enable = true;
      plugins.NixToks = false;
      plugins.NixMux = true;
    };
    shell.enable = false;
    fastfetch.enable = true;
    lf.enable = true;
  };
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    ffmpeg
    libqalculate
    manix
    typst
    gcc
    coreutils
    gawk
    gnumake
    sops
    openssh
    procps
    killall
    diffutils
    findutils
    utillinux
    tzdata
    hostname
    man
    gnugrep
    gnupg
    gnused
    gnutar
    bzip2
    gzip
    xz
    zip
    unzip
  ];

  xdg = {
    enable = true;
  };
  #Shell
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

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
        # Use this to not get error https://github.com/pure-fish/pure/issues/295#issuecomment-1673234460
        # set --universal pure_enable_container_detection false
        name = "pure";
        src = pure.src;
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
      # cli tools
      ls = "eza";
      cd = "z";
      mc = "ranger";
      h = "hx";
      # System Mantaining
      en = "hx ${self}";
      eh = "hx ${self}";
      clean = "nix-collect-garbage";
      yy = "nix-on-droid switch -F ${self}#NixMux";
      # Git
      g = "git";
      gal = "git add ./*";
      gcm = "git commit -m";
      gpr = "git pull --rebase";
      gpu = "git push";
      # Neorg
      v = "nvim";
      j = ''nvim -c "Neorg journal today"'';
    };
  };

  home.shellAliases = {
    # cli tools
    ls = "eza";
    cd = "z";
    mc = "ranger";
    h = "hx";
    # System Mantaining
    en = "hx ${self}";
    eh = "hx ${self}";
    clean = "nix-collect-garbage";
    yy = "nix-on-droid switch -F ${self}#NixMux";
    # Git
    g = "git";
    gal = "git add ./*";
    gcm = "git commit -m";
    gpr = "git pull --rebase";
    gpu = "git push";
    # Neorg
    v = "nvim";
    j = ''nvim -c "Neorg journal today"'';
  };

  programs = {
    ripgrep.enable = true;
    fd.enable = true;
    bat.enable = true;
    fzf = {
      enable = true;
    };
    zoxide = {
      enable = true;
    };
    eza = {
      enable = true;
      extraOptions = [ "--icons" ];
    };
  };

  home.sessionVariables = lib.mkForce {
    EDITOR = "hx";
    VISUAL = "hx";
    SUDO_EDITOR = "hx";
    SHELL = "bash";
  };
}
