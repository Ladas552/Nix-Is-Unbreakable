{ ... }:
{
  plugins.orgmode = {
    enable = true;
    settings = {
      org_agenda_files = "~/Documents/Org/**/*";
      org_default_notes_file = "~/Documents/Org/refile.org";
    };
  };
}
