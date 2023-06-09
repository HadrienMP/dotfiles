USER = $(shell whoami)

install:
	git add . && home-manager switch -b backup --flake ".#${USER}"

update:
	nix flake update

install-nixos:
	sudo cp nixos/configuration.nix /etc/nixos/configuration.nix
	sudo nixos-rebuild switch
	 
