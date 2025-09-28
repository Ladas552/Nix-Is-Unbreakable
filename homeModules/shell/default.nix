{
  pkgs,
  lib,
  config,
  meta,
  ...
}:

{
  options.customhm = {
    shell.enable = lib.mkEnableOption "enable shell";
  };
  imports = [
    ./fish.nix
    ./nushell.nix
  ];
  config = lib.mkIf config.customhm.shell.enable {
    # Shell programs
    home.packages = with pkgs; [
      wiki-tui
      duf
      unimatrix
      wgetpaste
      custom.gcp
    ];
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
      # Makes some rebuilds longer and breaks some complretions
      # But overall, good
      # carapace = {
      #   enable = true;
      # };
    };

    # Bash shell
    programs.bash = {
      enable = true;
      enableCompletion = true;
    };
    home.shellAliases = {
      # Better app names
      v = "nvim";
      # h = "hx";
      cd = "z";
      wiki = "wiki-tui";
      df = "duf";
      copypaste = "wgetpaste";
      cmatrix = "unimatrix -f -s 95";
      # fastfetch = "fastfetch | ${lib.getExe pkgs.lolcat}";
      # Nix mantainense
      clean = "nh clean all";
      yy = "nh os switch ${meta.self}";
      yyy = "nh os switch -u ${meta.self}";
      # en = "nvim -c 'cd ${meta.self}' ${meta.self}/flake.nix";
      # enn = "nvim -c 'cd ${meta.self}' ${meta.self}/hosts/${meta.host}/default.nix";
      # eh = "nvim -c 'cd ${meta.self}' ${meta.self}/flake.nix";
      eh = "hx ${meta.self}";
      en = "hx ${meta.self}";
      n = "ssh-add ~/.ssh/NixToks";
      # Git
      g = "git";
      gal = "git add ./*";
      gcm = "git commit -m";
      gpr = "git pull --rebase";
      gpu = "git push";
      # Neorg
      j = ''nvim -c "Neorg journal today"'';
      # directories
      mc = "lf";
      mcv = "lf ${config.xdg.userDirs.videos}";
      mcm = "lf ${config.xdg.userDirs.music}";
      mcc = "lf ~/.config/";
      mcp = "lf ${config.xdg.userDirs.pictures}";
    };
  };
}
