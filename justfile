#!/usr/bin/env just --working-directory ./ --justfile

default:
  @just --list

#     __  __
#    / / / /___  ____ ___  ___
#   / /_/ / __ \/ __ `__ \/ _ \
#  / __  / /_/ / / / / / /  __/
# /_/ /_/\____/_/ /_/ /_/\___/

hm-update-local:
    home-manager switch --flake .

hm-update-local-impure:
    home-manager switch --flake . --impure

hm-update-repo:
    home-manager switch --flake github:orzklv/nix

hm-update-repo-impure:
    home-manager switch --flake github:orzklv/nix --impure

#     _   ___      ____  _____
#    / | / (_)  __/ __ \/ ___/
#   /  |/ / / |/_/ / / /\__ \
#  / /|  / />  </ /_/ /___/ /
# /_/ |_/_/_/|_|\____//____/

nx-update-local:
    sudo nixos-rebuild switch --flake . --upgrade

nx-update-repo:
    sudo nixos-rebuild switch --flake github:orzklv/nix --upgrade

#     ____      _ __  _       ___
#    /  _/___  (_) /_(_)___ _/ (_)___  ___
#    / // __ \/ / __/ / __ `/ / /_  / / _ \
#  _/ // / / / / /_/ / /_/ / / / / /_/  __/
# /___/_/ /_/_/\__/_/\__,_/_/_/ /___/\___/

init-local:
    nix run github:nix-community/home-maagner -- switch --flake .

# Won't work if home-manager wasn't installed before
# echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
init-repo target:
    nix run github:nix-community/home-maagner -- switch --flake github:orzklv/nix{{target}}

#     ____             __
#    / __ \___  ____  / /___  __  __
#   / / / / _ \/ __ \/ / __ \/ / / /
#  / /_/ /  __/ /_/ / / /_/ / /_/ /
# /_____/\___/ .___/_/\____/\__, /
#           /_/            /____/

# Specify targets to update nixos for
NIXOS_TARGETS := "kolyma-1 kolyma-2"

deploy-nixos:
    for target in $(echo {{NIXOS_TARGETS}}); do \
        echo Updating target: $target; \
        sudo nixos-rebuild --flake github:orzklv/nix --target-host $target --build-host localhost switch; \
    done


# Specify targets to update home-manager for
HOME_TARGETS := "imac macbook-pro macbook-air"

deploy-hm:
    for target in $(echo {{HOME_TARGETS}}); do \
        ssh $target "nix store gc && home-manager switch --flake github:orzklv/nix"; \
    done

#   ______            __
#  /_  __/___  ____  / /____
#   / / / __ \/ __ \/ / ___/
#  / / / /_/ / /_/ / (__  )
# /_/  \____/\____/_/____/

repl:
  export NIXPKGS_ALLOW_UNFREE=1 && nix repl -f ./repl.nix --impure

format:
    nix fmt

test:
    nix flake check --all-systems
