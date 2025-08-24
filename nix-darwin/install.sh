#!/usr/bin/env sh

if ! type "darwin-rebuild" >/dev/null; then
	sudo mkdir /etc/nix-darwin
	sudo cp ./flake.nix /etc/nix-darwin/
	sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
	sudo nix run nix-darwin/master#darwin-rebuild -- switch
else
	sudo cp ./flake.nix /etc/nix-darwin/
	sudo darwin-rebuild switch
fi

sudo cp ./lafayette_macos_v0.9.keylayout "/Library/Keyboard Layouts/"
