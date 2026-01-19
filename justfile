#!/usr/bin/env just --working-directory ./ --justfile

default:
  @just --list

repl:
  export NIXPKGS_ALLOW_UNFREE=1 && nix repl -f ./repl.nix --impure

format:
    nix fmt

test:
    nix flake check --all-systems --show-trace

build-darwin:
  nix build .#darwinConfigurations.Sokhibjons-Mac-Studio.config.system.build.toplevel --show-trace

build-nixos:
  nix build .#nixosConfigurations.Laboratory.config.system.build.toplevel --show-trace
