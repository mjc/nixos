#!/usr/bin/env sh


# NOTE: if you are doing a major upgrade you must pass --upgrade
operating_system="$(uname -s)"
case "${operating_system}" in
    Linux*)
        nix flake update
        doas nixos-rebuild switch --refresh --flake "$(pwd)";;
    Darwin*)
        nix flake update
        darwin-rebuild switch --refresh --flake "$(pwd)";;
esac
nix-collect-garbage --delete-older-than 30d
nix-store --optimize
