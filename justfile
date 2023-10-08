update:
    home-manager switch --flake .

init:
    nix run github:nix-community/home-manager -- switch --flake .

init-expo:
    nix --extra-experimental-features 'nix-command flakes' run github:nix-community/home-manager -- switch --flake .