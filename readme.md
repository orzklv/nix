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

## Install Homebrew (if it's nix-darwin) configurations

Basically, we will go with official way of installing homebrew to get nix-darwin configurations working:

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install my configurations

### Home Manager configs

I do have many configurations written on my nix flake, however, for my macs, it actually detects automatically. However, for Linux machines, it's necessary to show which build to use:

```shell
# Apple Macs
nix run github:nix-community/home-maagner -- switch --flake github:orzklv/nix#sakhib@apple

# Intel Apple Macs
nix run github:nix-community/home-maagner -- switch --flake github:orzklv/nix#sakhib@old-apple

# Non NixOS Linux
nix run github:nix-community/home-maagner -- switch --flake github:orzklv/nix#sakhib@unstable

# Stable Latest NixOS
nix run github:nix-community/home-maagner -- switch --flake github:orzklv/nix#sakhib@stable
```

### NixOS configurations

I've written ready configurations for my machines that are using NixOS, so here you are:

```shell
# Station (Home Gaming)
sudo nixos-rebuild switch --flake github:orzklv/nix#Guts --upgrade

# Experimental (Work PC)
sudo nixos-rebuild switch --flake github:orzklv/nix#Experimental --upgrade
```

### Darwin configurations

The same actually goes for my Darwin machines as well, everything is ready for setup:

```shell
# MacBook Pro
nix run nix-darwin -- switch --flake github:orzklv/nix#Sokhibjons-MacBook-Pro # or
darwin-rebuild switch --flake github:orzklv/nix#Sokhibjons-MacBook-Pro

# Mac Studio
nix run nix-darwin -- switch --flake github:orzklv/nix#Sokhibjons-Mac-Studio # or
darwin-rebuild switch --flake github:orzklv/nix#Sokhibjons-Mac-Studio
```

> If you hit GitHub's rate limit, put your GitHub token in `~/.config/nix/nix.conf` file like this:
> ```conf
> access-tokens = github.com=<YOUR_TOKEN>
> ```

## Thanks

- [Template](https://github.com/Misterio77/nix-starter-configs) - Started with this template
- [Example](https://github.com/Misterio77/nix-config) - Learned from his configurations
- [Home Manager](https://github.com/nix-community/home-manager) - Simplyifying my life and avoid frustrations
- [Nix](https://nixos.org/) - Masterpiece of package management

## License

This project is licensed under the MIT License - see the [LICENSE](license) file for details.

<p align="center">
    <img src=".github/assets/footer.png" alt="Orzklv's {Nix}">
</p>
