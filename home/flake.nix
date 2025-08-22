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
    {
      homeConfigurations = {
        "ash" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            config.allowUnfree = true;
            system = "aarch64-darwin";
          };
          modules = [
            ./home.nix
            ./mac-home.nix
            { home.packages = [ bootstrap-kata.packages."aarch64-darwin".bootstrap-kata ]; }
          ];
        };
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
