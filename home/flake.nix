{
  description = "Home Manager Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    bootstrap-kata.url = "gitlab:HadrienMP/bootstrap-kata";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, bootstrap-kata, zen-browser, ghostty, ... } @ inputs :
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
          ./ghostty.nix
          ./${platform}-home.nix
        ];
        extraSpecialArgs = { inherit inputs; system = platform;};
      };
    in
    {
      homeConfigurations = {
        "ash" = home-config "aarch64-darwin";
        "h" = home-config "x86_64-linux";
      };
    };
}
