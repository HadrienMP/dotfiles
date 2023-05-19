USER = $(shell whoami)

install:
	home-manager switch --flake ".#${USER}"
	 
