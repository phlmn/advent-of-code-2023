# https://adventofcode.com/2023/day/1
let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  strings = import ./utils/strings.nix;
  files = import ./utils/files.nix;
  trivial = import ./utils/trivial.nix;

  digitsMap = {
    "0" = 0;
    "1" = 1;
    "2" = 2;
    "3" = 3;
    "4" = 4;
    "5" = 5;
    "6" = 6;
    "7" = 7;
    "8" = 8;
    "9" = 9;
  };

  digitLiteralsMap = {
    "zero" = 0;
    "one" = 1;
    "two" = 2;
    "three" = 3;
    "four" = 4;
    "five" = 5;
    "six" = 6;
    "seven" = 7;
    "eight" = 8;
    "nine" = 9;
  };

  sumInts = builtins.foldl' builtins.add 0;

  findAllAndParse = mapping: trivial.pipe2 [
    (strings.findAll (builtins.attrNames mapping))
    (map (match: mapping.${match.text}))
  ];

  processLine = mapping: trivial.pipe2 [
    (findAllAndParse mapping)
    (digits: (lib.head digits * 10) + (lib.last digits))
  ];
in
{
  part1 = lib.pipe ./inputs/day_1.txt [
    files.readLines
    (map (processLine digitsMap))
    sumInts
  ];

  part2 = lib.pipe ./inputs/day_1.txt [
    files.readLines
    (map (processLine (digitsMap // digitLiteralsMap)))
    sumInts
  ];
}
