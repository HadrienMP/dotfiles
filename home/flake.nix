{
  description = "Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    bootstrap-kata.url = "gitlab:HadrienMP/bootstrap-kata";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, bootstrap-kata, ... }:
    let
      home-config = platform: home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          config.allowUnfree = true;
          system = platform;
        };
        modules = [
          ./home.nix
          ./${platform}-home.nix
          { home.packages = [ bootstrap-kata.packages.${platform}.bootstrap-kata ]; }
        ];
      };
    in
    {
      homeConfigurations = {
        "ash" = home-config "aarch64-darwin";
        "h" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            config.allowUnfree = true;
            config.permittedInsecurePackages = [
              "electron-27.3.11" # For logseq
            ];
            system = "x86_64-linux";
          };
          modules = [
            ./home.nix
            ./linux-home.nix
            { home.packages = [ bootstrap-kata.packages."x86_64-linux".bootstrap-kata ]; }
          ];
        };
      };
    };
}
