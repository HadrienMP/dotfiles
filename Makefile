install:
	nix run . switch -- -b backup --flake .
	 
