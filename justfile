init:
    nix run github:nix-community/home-manager -- switch --flake .

update:
    home-manager switch --flake .