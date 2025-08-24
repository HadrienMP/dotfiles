#!/usr/bin/env sh

cp ./flake.nix ~/.config/nix-darwin/flake.nix

if ! type "darwin-rebuild" >/dev/null; then
	sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin2
	sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.config/nix-darwin
else
	sudo darwin-rebuild switch --flake ~/.config/nix-darwin
fi

sudo cp ./lafayette_macos_v0.9.keylayout "/Library/Keyboard Layouts/"
