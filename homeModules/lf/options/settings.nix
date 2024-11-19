{ ... }:

{
  programs.lf.settings = {
    period = 1;
    dircounts = true;
    info = "size";
    dupfilefmt = "%f_";
    findlen = 0;
    # icons = true;
    incsearch = true;
    ignorecase = true;
    smartcase = true;
    shell = "bash";
    scrolloff = 8;
    watch = true;
  };
}
