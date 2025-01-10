{
  config,
  lib,
  pkgs,
  meta,
  ...
}:

{
  options.custom = {
    thunar.enable = lib.mkEnableOption "enable thunar";
  };

  config = lib.mkIf config.custom.thunar.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-volman
        thunar-archive-plugin
        thunar-media-tags-plugin
      ];
    };
    services = {
      gvfs.enable = true;
      tumbler.enable = true;
    };
    environment.systemPackages = [ pkgs.ffmpegthumbnailer ];

    home-manager.users."${meta.user}".home.file.".config/Thunar/uca.xml".text = # xml
      ''
        <?xml version="1.0" encoding="UTF-8"?>
        <actions>
          <action>
            <icon>utilities-terminal</icon>
            <name>Open Terminal Here</name>
            <submenu></submenu>
            <unique-id>1734179588135391-1</unique-id>
            <command>cd %f &amp;&amp; "$TERMINAL"</command>
            <description>Example for a custom action</description>
            <range></range>
            <patterns>*</patterns>
            <startup-notify/>
            <directories/>
            </action>
          </actions>
      '';
  };
}
