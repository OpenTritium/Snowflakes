{
  description = "OpenTritium";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/v1.11.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs@{
      home-manager,
      plasma-manager,
      nixpkgs,
      disko,
      self,
      ...
    }:
    let
      system = "x86_64-linux";
      inherit (self) outputs;
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs outputs; };
          modules = [
            disko.nixosModules.disko
            ./harddisk.nix
            ./kde.nix
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                backupFileExtension = "backup";
                useGlobalPkgs = true;
                useUserPackages = true;
                sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
                users.tritium = import ./home.nix;
              };
            }
          ];
        };
      };
    };
}
