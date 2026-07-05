# Shared NixOS user config for max
# Import users/max/desktop.nix or users/max/server.nix for host-type-specific extras
{ pkgs, ... }:

{
  users.users.max = {
    isNormalUser = true;
    description = "Maxine Keneau";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBHz2/55nxbbtyuPcbJuVV+K/vzjsUHDZyQzxJgho4ee max@orcachill.in"
    ];
  };
}
