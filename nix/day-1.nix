# https://adventofcode.com/2023/day/1
let
    pkgs = import <nixpkgs> {};
    lib = pkgs.lib;
    strings = import ./utils/strings.nix;

    digits_map = {
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

    digit_literals_map = {
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

    find_all_and_map = map: line:
      let
        matches = strings.find_all line (builtins.attrNames map) 0;
      in
        builtins.map (match: map.${match.text}) matches;

    value_from_line = map: line:
      let
        values = find_all_and_map map line;
      in
        (lib.lists.head values * 10) + (lib.lists.last values);

    sum_ints = builtins.foldl' (acc: val: acc + val) 0;
    total_value = map: lines: sum_ints (builtins.map (l: value_from_line map l) lines);
in
  builtins.toJSON {
    part_1 = total_value digits_map (strings.lines (builtins.readFile ./inputs/day_1.txt));
    part_2 = total_value (digits_map // digit_literals_map) (strings.lines (builtins.readFile ./inputs/day_1.txt));
  }
