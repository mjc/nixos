#!/usr/bin/env sh

sudo nixos-rebuild switch --flake "$(pwd)#$1"
nix-store --optimize