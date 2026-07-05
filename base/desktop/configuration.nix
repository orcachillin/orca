# Base configuration shared by all desktop hosts
{ pkgs, lib, inputs, self, ... }:

{
  imports = [
    "../common/configuration.nix"
    inputs.home-manager.nixosModules.home-manager
  ];

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

  # Common desktop packages
  environment.systemPackages = with pkgs; [
    kdePackages.kate
    kdePackages.yakuake 
  ];

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs self; };
    
    users = builtins.listToAttrs (map (u: {
      name = u;
      value = { imports = [ ../../users/${u}/home-manager/home.nix ]; };
      }) (builtins.filter
        (u: builtins.pathExists ../../users/${u}/home-manager/home.nix)
        (builtins.attrNames (builtins.removeAttrs (builtins.readDir ../../users) [ "default.nix" ]))
      ));
  };

  # Browser
  programs.firefox.enable = true;
}
