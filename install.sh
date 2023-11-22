#!/bin/bash

# Ensure the script is run as root
# if [ "$EUID" -ne 0 ]
#   then echo "Please run as root"
#   exit
# fi

# Install Nix
echo "Installing Nix..."
sh <(curl -L https://nixos.org/nix/install) --daemon

# Set up environment for non-login shells (like Codespaces)
echo '. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' >> ~/.bashrc

# Load Nix environment immediately for the current session
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

echo "Nix installation complete."

# Switch to the non-root user for Home Manager installation
echo "Switching to user: $USER"

# Install Home Manager
echo "Installing Home Manager..."
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Activate Home Manager
echo "Activating Home Manager..."
home-manager switch --flake github:orzklv/nix

echo "Home Manager installation and configuration complete."