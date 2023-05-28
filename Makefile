USER = $(shell whoami)

install:
	git add . && home-manager switch --flake ".#${USER}"

update:
	nix flake update
	 
