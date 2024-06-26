{
  description = "Ash nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  };

  outputs = {self, nixpkgs, ...}:
    let
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        akachat = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [./configuration.nix];
        };
      };
    };
}
