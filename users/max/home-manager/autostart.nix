{ pkgs, ... }:

{
xdg.configFile."autostart/netbird-ui-default.desktop" = {
    text = ''
      [Desktop Entry]
      Type=Application
      Exec=/run/current-system/sw/bin/netbird-ui-default
      Hidden=false
      NoDisplay=false
      Name=NetBird UI @ default
      Icon=netbird
      Comment=Secure private WireGuard mesh network client
      Terminal=false
    '';
  };

   xdg.configFile."autostart/org.kde.yakuake.desktop".source = 
      "${pkgs.kdePackages.yakuake}/share/applications/org.kde.yakuake.desktop";
}
