#!/usr/bin/env sh

# NOTE: if you are doing a major upgrade you must pass --upgrade
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     doas nixos-rebuild switch --refresh --flake "$(pwd)";;
    Darwin*)    darwin-rebuild switch --refresh --flake "$(pwd)";;
esac
# nix-collect-garbage --delete-older-than 30d
nix-store --optimize
