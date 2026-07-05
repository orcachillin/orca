# Desktop-specific user config for max
{ ... }:

{

  imports = [
    # ./apps/firefox.nix
  ];

  users.users.max.extraGroups = [
    "wheel"
    "docker"
    "networkmanager"
    "netbird-default"
    "netbird-dma"
  ];
}
