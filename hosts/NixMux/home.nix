{
  pkgs,
  lib,
  config,
  meta,
  ...
}:
{
  imports = [ ./../../homeModules ];

  customhm = {
    helix.enable = true;
    nixvim.enable = true;
    shell.enable = false;
    fastfetch.enable = true;
    gh.enable = true;
    lf.enable = true;
    chawan.enable = true;
    git.enable = true;
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
    shellInit = # fish
      ''
        set -gx pure_enable_container_detection false
        abbr --set-cursor --command nix rn run nixpkgs#%
        abbr --set-cursor --command nix bn build nixpkgs#%
        abbr --set-cursor --command nix sn shell nixpkgs#%
        abbr --set-cursor --command nix rg run github:%
        abbr --set-cursor --command nix bg build github:%
        abbr --set-cursor --command nix sg shell github:%
        abbr --set-cursor --command nix nr run nixpkgs#%
        abbr --set-cursor --command nix nb build nixpkgs#%
        abbr --set-cursor --command nix ns shell nixpkgs#%
        abbr --set-cursor --command nix gr run github:%
        abbr --set-cursor --command nix gb build github:%
        abbr --set-cursor --command nix gs shell github:%
      '';

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

    preferAbbrs = true;
    shellAbbrs = config.home.shellAliases;
  };
  home.shellAliases = {
    # cli tools
    cd = "z";
    mc = "lf";
    h = "hx";
    # System Mantaining
    en = "hx ${meta.self}";
    eh = "hx ${meta.self}";
    clean = "nix-collect-garbage";
    yy = "nix-on-droid switch -F ${meta.self}#NixMux";
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
  };

  home.sessionVariables = lib.mkForce {
    EDITOR = "hx";
    VISUAL = "hx";
    SUDO_EDITOR = "hx";
    SHELL = "bash";
  };
}
