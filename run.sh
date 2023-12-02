#/usr/bin/env bash
nix-instantiate --eval --strict --show-trace "$1.nix"
