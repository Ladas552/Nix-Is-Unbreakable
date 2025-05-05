{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{

  vim = {
    # UI
    theme = {
      enable = true;
      name = "catppuccin";
      style = "macchiato";
    };
    ui = {
      colorizer = {
        enable = true;
        setupOpts.filetypes."*" = { };
      };
    };
    visuals.nvim-web-devicons.enable = true;
    dashboard.dashboard-nvim = {
      enable = true;
      setupOpts = {
        theme = "doom";
        shortcut_type = "number";
        config = {
          header = [
            "                                                                "
            "██╗      █████╗ ██████╗  █████╗ ███████╗███████╗███████╗██████╗ "
            "██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝╚════██╗"
            "██║     ███████║██║  ██║███████║███████╗███████╗███████╗ █████╔╝"
            "██║     ██╔══██║██║  ██║██╔══██║╚════██║╚════██║╚════██║██╔═══╝ "
            "███████╗██║  ██║██████╔╝██║  ██║███████║███████║███████║███████╗"
            "╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚══════╝"
            "                                                                "
          ];
          center = [
            {
              action = "Telescope oldfiles";
              desc = " Recent files";
              icon = "󰥔 ";
              key = "R";
            }
            {
              action = "Telescope find_files";
              desc = " Find files";
              icon = " ";
              key = "F";
            }
            {
              action = "ene | startinsert";
              desc = " New file";
              icon = " ";
              key = "N";
            }
            {
              action = "Neorg workspace life";
              desc = " Neorg Life";
              icon = "󰠮 ";
              key = "E";
            }
            {
              action = "Neorg workspace work";
              desc = " Neorg Work";
              icon = " ";
              key = "W";
            }
            {
              action = "Neorg journal today";
              desc = " Neorg Journal";
              icon = "󰛓 ";
              key = "J";
            }
            {
              action = "qa";
              desc = " Quit";
              icon = "󰩈 ";
              key = "Q";
            }
          ];
          footer = [ "Just Do Something Already!" ];
        };
      };
    };
    # Workflow
    telescope = {
      enable = true;
      mappings = {
        buffers = null;
        diagnostics = "<leader>dd";
        findFiles = "<leader>ff";
        findProjects = null;
        gitBranches = null;
        gitBufferCommits = null;
        gitCommits = null;
        gitStash = null;
        gitStatus = null;
        helpTags = null;
        liveGrep = "<leader>/";
        lspDefinitions = null;
        lspDocumentSymbols = null;
        lspImplementations = null;
        lspReferences = null;
        lspTypeDefinitions = null;
        lspWorkspaceSymbols = null;
        open = null;
        resume = null;
        treesitter = null;
      };
    };
  };
}
