# Base configuration shared by all desktop hosts
{ pkgs, lib, inputs, ... }:

{

  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Networking
  networking.networkmanager.enable = true;

  # Locale (desktops assume en_US, override per-host if needed)
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Graphical environment
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Printing
  services.printing.enable = true;

  # Audio (pipewire replaces pulseaudio)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  # Common desktop packages
  environment.systemPackages = with pkgs; [
    kdePackages.kate
    git
    nnn
    btop
    fastfetch
  ];

  # Home Manager
  home-manager.users = builtins.listToAttrs (map (u: {
  name = u;
  value = { imports = [ ../../users/${u}/home-manager/home.nix ]; };
}) (builtins.filter
  (u: builtins.pathExists ../../users/${u}/home-manager/home.nix)
  (builtins.attrNames (builtins.removeAttrs (builtins.readDir ../../users) [ "default.nix" ]))
));

  # Allow unfree (firefox, etc.)
  nixpkgs.config.allowUnfree = true;

  # Browser
  programs.firefox.enable = true;

  system.stateVersion = "25.11";
}
