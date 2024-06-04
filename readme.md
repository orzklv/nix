<p align="center">
    <img src=".github/assets/header.png" alt="Orzklv's {Nix}">
</p>

<p align="center">
    <h3 align="center">My nix configurations for all my NixOS & Apple machines.</h3>
</p>

<p align="center">
    <img align="center" src="https://img.shields.io/github/languages/top/orzklv/nix?style=flat&logo=nixos&logoColor=ffffff&labelColor=242424&color=242424" alt="Top Used Language">
    <a href="https://t.me/orzklvb"><img align="center" src="https://img.shields.io/badge/Chat-grey?style=flat&logo=telegram&logoColor=ffffff&labelColor=242424&color=242424" alt="Telegram Channel"></a>
    <a href="https://github.com/orzklv/nix/actions/workflows/test.yml"><img align="center" src="https://img.shields.io/github/actions/workflow/status/orzklv/nix/test.yml?style=flat&logo=github&logoColor=ffffff&labelColor=242424&color=242424" alt="Test CI"></a>
</p>

## About

In this repository I keep all my configurations and dot files to maintain my healthy development environment for any case. It contains configurations
for shell and environments for any linux distro and macos. It comes with installer to shorten my time spending on set up.

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

Before installing my configuration, we need to get nix ready in our machine. We could have used official installer, but due to many reasons, I prefer going with installer by [determinate.systems](https://determinate.systems/oss/).

```shell
curl --proto '=https' --tlsv1.2 -sSf -L \
  https://install.determinate.systems/nix | sh -s -- install
```

## Install Home Manager

Installation of Home Manager differs depending on what OS you use. For MacOS or Non-Nixos target, it's just a simple command, however, on NixOS, it's a bit different story (go to [NixOS & Home Manager](#nixos--home-manager-configs)).

#### MacOS & Non NixOS

```shell
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Optional, just go with nix run if you want...
nix-shell '<home-manager>' -A install
```

#### NixOS (if you want only home-manager configs)

```shell
# Unstable
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
sudo nix-channel --update

# Stable 24.05
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
sudo nix-channel --update
```

## Install my configurations

### Home Manager configs

I do have many configurations written on my nix flake, however, for my macs, it actually detects automatically. However, for Linux machines, it's necessary to show which build to use:

```shell
# Apple Macs
home-manager switch --flake github:orzklv/nix#sakhib@apple

# Intel Apple Macs
home-manager switch --flake github:orzklv/nix#sakhib@old-apple

# Non NixOS Linux
home-manager switch --flake github:orzklv/nix#sakhib@unstable

# Stable Latest NixOS
home-manager switch --flake github:orzklv/nix#sakhib@stable
```

If you skipped home-manager installation part, you can use nix run to instantly apply my configurations. It should be something like this:

```shell
# Replace <target> with any of sakhib@apple, sakhib@old-apple, sakhib@unstable, sakhib@stable
nix run github:nix-community/home-maagner -- switch --flake github:orzklv/nix#<target>
```

### NixOS & Home Manager configs

I've written ready configurations for my machines that are using NixOS, so here you are:

```shell
# Station (Home Gaming)
sudo nixos-rebuild switch --flake github:orzklv/nix#Guts --upgrade

# Experimental (Work PC)
sudo nixos-rebuild switch --flake github:orzklv/nix#Experimental --upgrade
```

## Thanks

- [Template](https://github.com/Misterio77/nix-starter-configs)
- [Example](https://github.com/Misterio77/nix-config)
- [Home Manager](https://github.com/nix-community/home-manager)
- [Nix](https://nixos.org/)

## License

This project is licensed under the MIT License - see the [LICENSE](license) file for details.

<p align="center">
    <img src=".github/assets/footer.png" alt="Orzklv's {Nix}">
</p>