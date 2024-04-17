#!/usr/bin/env sh

flake="${1:tina}"

nix-channel --update
# NOTE: if you are doing a major upgrade you must pass --upgrade
sudo nixos-rebuild switch --flake "$(pwd)#$flake"
nix-collect-garbage --delete-older-than 30d
nix-store --optimize