{
  description = "Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    {
      homeConfigurations = {
        "ash" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            config.allowUnfree = true;
            system = "aarch64-darwin";
          };
          modules = [ ./home.nix ./mac-home.nix ];
        };
        "h" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            config.allowUnfree = true;
            system = "x86_64-linux";
          };
          modules = [ ./home.nix ./linux-home.nix ];
        };
      };
    };
}
