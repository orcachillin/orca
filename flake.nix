{
  description = "orca - max's nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Plasma manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    lib = nixpkgs.lib;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;

    userDirs = builtins.attrNames (builtins.readDir ./users);
    usersWithHomeManager = builtins.filter
      (u: builtins.pathExists ./users/${u}/home-manager)
      userDirs;

    hosts = builtins.attrNames self.nixosConfigurations;

    mkHomeConfig = user: host: home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${self.nixosConfigurations.${host}.config.nixpkgs.system};
      extraSpecialArgs = {inherit inputs;};
      modules = [ ./users/${user}/home-manager/home.nix ];
    };
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays {inherit inputs;};
    nixosModules = import ./modules/nixos;
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      kyra = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/kyra/configuration.nix
        ];
      };
    };

    homeConfigurations = lib.foldl' (acc: user:
      acc // lib.genAttrs hosts (host: mkHomeConfig user host)
    ) {} usersWithHomeManager;
  };
}
