#!/usr/bin/env sh

# NOTE: if you are doing a major upgrade you must pass --upgrade
sudo nixos-rebuild switch --refresh --flake $(pwd)
# nix-collect-garbage --delete-older-than 30d
nix-store --optimize