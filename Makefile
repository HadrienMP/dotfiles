USER = $(shell whoami)
ARCH = $(shell uname -s)

ifeq (Darwin, ${ARCH})
install: install-home
else
install: install-nixos install-home
endif

update: update-nixos update-nix-darwin update-home

# -----------------------------------
#  Home Manager
# -----------------------------------
install-home:
	git add . && cd home && home-manager switch --flake ".#${USER}"
update-home:
	cd home && nix flake update

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
	 
update-nix-darwin:
	cd nix-darwin && nix flake update

