{ config, pkgs, ... }:

{
  # Enable the netbird service
  services.netbird.clients = {
    default = {
      port = 51820;
      ui.enable = true;
      openFirewall = true;
      openInternalFirewall = true;

      login = {
        enable = true;
        setupKeyFile = "~/.config/netbird/default.key";
      };

      environment = {
        NB_MANAGEMENT_URL = "https://ntw.gart.sh:443";
        NB_ADMIN_URL = "https://ntw.gart.sh:443";
      };
    };

     dma = {
      port = 51821;
      ui.enable = true;
      openFirewall = true;
      openInternalFirewall = true;

      login = {
        enable = false;
        setupKeyFile = "~/.config/netbird/dma.key";
      };

      environment = {
        NB_MANAGEMENT_URL = "https://netbird.dma.space:443";
        NB_ADMIN_URL = "https://netbird.dma.space:443";
      };
    };
  };

}
