# Host configuration for kyra
{ inputs, self, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../base/desktop/configuration.nix
    ../../modules/nixos/flatpak.nix
    ../../users
    ../../users/max/desktop.nix
  ];

  nixpkgs = {
    overlays = [
      self.overlays.additions
      self.overlays.modifications
      self.overlays.unstable-packages
    ];
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
    };
    channel.enable = false;
  };

  # Host-specific
  networking.hostName = "kyra";
  time.timeZone = "America/Los_Angeles";

  orca.flatpak.apps = [
    "org.onlyoffice.desktopeditors"
  ];
}
