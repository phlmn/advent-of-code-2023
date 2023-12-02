# https://adventofcode.com/2023/day/1
let
    pkgs = import <nixpkgs> {};
    lib = pkgs.lib;
    strings = import ./utils/strings.nix;
    files = import ./utils/files.nix;

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

    findAllAndMap = map: line:
      let
        matches = strings.findAll line (builtins.attrNames map) 0;
      in
        builtins.map (match: map.${match.text}) matches;

    valueFromLine = map: line:
      let
        values = findAllAndMap map line;
      in
        (lib.lists.head values * 10) + (lib.lists.last values);

    sumInts = builtins.foldl' (acc: val: acc + val) 0;
    totalValue = map: lines: sumInts (builtins.map (l: valueFromLine map l) lines);
in
  builtins.toJSON {
    part1 = totalValue digitsMap (files.readLines ./inputs/day_1.txt);
    part2 = totalValue (digitsMap // digitLiteralsMap) (files.readLines ./inputs/day_1.txt);
  }
