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
          config.permittedInsecurePackages = [
            "electron-27.3.11" # For logseq
          ];
          system = platform;
        };
        modules = [
          ./home.nix
          ./fish.nix
          ./git.nix
          ./nvim.nix
          ./tmux.nix
          ./${platform}-home.nix
          { home.packages = [ bootstrap-kata.packages.${platform}.bootstrap-kata ]; }
        ];
      };
    in
    {
      homeConfigurations = {
        "ash" = home-config "aarch64-darwin";
        "h" = home-config "x86_64-linux";
      };
    };
}
