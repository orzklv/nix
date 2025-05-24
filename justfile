#!/usr/bin/env just --working-directory ./ --justfile

default:
  @just --list

#     _   ___      ____  _____
#    / | / (_)  __/ __ \/ ___/
#   /  |/ / / |/_/ / / /\__ \
#  / /|  / />  </ /_/ /___/ /
# /_/ |_/_/_/|_|\____//____/

nx-update-local:
    sudo nixos-rebuild switch --flake . --upgrade

nx-update-repo:
    sudo nixos-rebuild switch --flake github:orzklv/nix --upgrade

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
    nix flake check --all-systems --show-trace

build-darwin:
  nix build .#darwinConfigurations.Sokhibjons-MacBook-Pro.config.system.build.toplevel --show-trace

build-nixos:
  nix build .#nixosConfigurations.Laboratory.config.system.build.toplevel --show-trace
