#!/usr/bin/env sh

sudo nixos-rebuild switch --flake $(pwd)#default
nix-store --optimize