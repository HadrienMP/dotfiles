USER = $(shell whoami)

install: install-nixos install-home
update: update-nixos update-home

# -----------------------------------
#  Home Manager
# -----------------------------------
install-home:
	git add . && home-manager switch --flake ".#${USER}"
update-home:
	nix flake update

# -----------------------------------
#  Nixos
# -----------------------------------
install-nixos:
	sudo nixos-rebuild switch --flake nixos/
update-nixos:
	cd nixos && nix flake update

# -----------------------------------
#  Darnwin
# -----------------------------------
install-nix-darwin:
	cp nix-darwin/flake.nix ~/.config/nix-darwin/flake.nix
	darwin-rebuild switch --flake ~/.config/nix-darwin
	sudo cp ./nix-darwin/lafayette_macos_v0.9.keylayout "/Library/Keyboard Layouts/"
	 
