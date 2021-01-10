#!/usr/bin/env bash

# Set up /nix
install -d -m755 ~/.nix
sudo install -d -m755 -o $(id -u) -g $(id -g) /nix
sudo mount --bind ~/.nix /nix

# Install nix
curl -L https://nixos.org/nix/install | sh
. $HOME/.nix-profile/etc/profile.d/nix.sh

# Add channel
nix-channel --add https://channels.nixos.org/nixpkgs-unstable nixpkgs
nix-channel --update

# Install Flakes
nix-env -iA nixpkgs.nixFlakes
sudo mkdir -p /etc/nix
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
