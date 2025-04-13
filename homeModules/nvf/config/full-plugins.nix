{
  pkgs,
  lib,
  inputs,
  config,
  meta,
  ...
}:
{
  options.customhm = {
    nvf.plugins.NixToks = lib.mkEnableOption "Neovim plugins for desktop";
  };

  config = lib.mkIf (config.customhm.nvf.enable && config.customhm.nvf.plugins.NixToks) {
    programs.nvf.settings.vim = {
      telescope = {
        enable = true;
        mappings = {
          buffers = "";
          diagnostics = "<leader>dd";
          findFiles = "<leader>ff";
          findProjects = "";
          gitBranches = "";
          gitBufferCommits = "";
          gitCommits = "";
          gitStash = "";
          gitStatus = "";
          helpTags = "";
          liveGrep = "<leader>/";
          lspDefinitions = "";
          lspDocumentSymbols = "";
          lspImplementations = "";
          lspReferences = "";
          lspTypeDefinitions = "";
          lspWorkspaceSymbols = "";
          open = "";
          resume = "";
          treesitter = "";
        };
      };
    };
  };
}
