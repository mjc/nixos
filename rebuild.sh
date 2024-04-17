#!/usr/bin/env sh

# NOTE: if you are doing a major upgrade you must pass --upgrade
sudo nixos-rebuild switch --flake "$(pwd)#$1"
nix-store --optimize