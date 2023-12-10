update:
    home-manager switch --flake .

update-impure:
    home-manager switch --flake . --impure

init:
    nix run github:nix-community/home-manager -- switch --flake .

format:
    nixpkgs-fmt .