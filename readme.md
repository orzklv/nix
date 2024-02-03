<header>
<img src="https://www.orzklv.uz/favicons/logo.png" alt="logo" height="100" align="left">
<h1 style="display: inline">Nix</h1>

My nix configurations made for all my NixOS machines.

</header>

[![GitHub top language](https://img.shields.io/github/languages/top/orzklv/nix?style=flat-square&logo=github)](https://github.com/orzklv/nix)
[![Channel](https://img.shields.io/badge/Chat-grey?style=flat-square&logo=telegram)](https://t.me/orzklvb)

[//]: # ([![Shellcheck CI]&#40;https://github.com/orzklv/dots/actions/workflows/test.yml/badge.svg&#41;]&#40;https://github.com/orzklv/dots/actions/workflows/test.yml&#41;)

## About

In this repository I keep all my configurations and dot files to maintain my healthy development environment for any case. It contains configurations
for shell and environments like zsh (arch-linux, macos), powershell (windows). It comes with installer to shorten my time spending on set up.

> Everytime I installed my dev env manually by myself, I started feeling like a garbage myself... So here you are!

## Features

- Syntax Highlighting
- Auto Completions
- Auto Suggestions
- Rust made replacements
- Key configurations
- Software configurations
- Selfmade scripts

## Install Nix

Before installing my configuration, we need to perform some dependency installation get nix ready in our machine.

```shell
# MacOS
sh <(curl -L https://nixos.org/nix/install)

# Linux
sh <(curl -L https://nixos.org/nix/install) --daemon
```

## Install Home Manager

Installation of Home Manager differs depending on what OS you use. For MacOS, it's just a simple command, however, for Linux, it's a bit more complicated.

#### MacOS & Non NixOS

```shell
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```

#### NixOS (if you want only home-manager configs)

```shell
# Unstable
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

# Stable 23.11
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
sudo nix-channel --update
```

## Install my configurations

### Home Manager configs

I do have many configurations written on my nix flake, however, for my macs, it actually detects automatically. However, for Linux machines, it's necessary to show which build to use:

```shell
# Apple Macs
home-manager switch --flake github:orzklv/nix#sakhib@apple

# Non NixOS
home-manager switch --flake github:orzklv/nix#sakhib@unstable

# NixOS
home-manager switch --flake github:orzklv/nix#sakhib@stable
```

### NixOS & Home Manager configs

I've written ready configurations for my machines that are using NixOS, so here you are:

```shell
# Guts (Home Gaming)
sudo nixos-rebuild --flake github:orzklv/nix#Guts --upgrade

# Griffith (Work Station)
sudo nixos-rebuild --flake github:orzklv/nix#Griffith --upgrade
```

## Thanks

- [Template](https://github.com/Misterio77/nix-starter-configs)
- [Example](https://github.com/Misterio77/nix-config)
- [Home Manager](https://github.com/nix-community/home-manager)
- [Nix](https://nixos.org/)

## License

This project is licensed under the MIT License - see the [LICENSE](license) file for details.
