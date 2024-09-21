USER = $(shell whoami)

install: home-manager-install
update: home-manager-update

# -----------------------------------
#  Home Manager
# -----------------------------------
home-manager-install:
	git add . && home-manager switch --flake ".#${USER}"
home-manager-update:
	nix flake update

# -----------------------------------
#  Nixos
# -----------------------------------
nixos-install:
	sudo nixos-rebuild switch --flake nixos/
nixos-update:
	cd nixos && nix flake update

# -----------------------------------
#  Darnwin
# -----------------------------------
install-nix-darwin:
	cp nix-darwin/flake.nix ~/.config/nix-darwin/flake.nix
	darwin-rebuild switch --flake ~/.config/nix-darwin
	sudo cp ./nix-darwin/lafayette_macos_v0.9.keylayout "/Library/Keyboard Layouts/"
	 
