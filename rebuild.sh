#!/usr/bin/env sh

flake="${1:tina}"

# NOTE: if you are doing a major upgrade you must pass --upgrade
sudo nixos-rebuild switch --flake "$(pwd)#$flake"
nix-store --optimize