#/usr/bin/env bash
nix-instantiate --eval --show-trace "$1.nix"
