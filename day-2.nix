# https://adventofcode.com/2023/day/1
let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  files = import ./utils/files.nix;
  trivial = import ./utils/trivial.nix;

  sumInts = builtins.foldl' builtins.add 0;

  parseRound = trivial.pipe2 [
    (lib.strings.splitString ", ")
    (map (trivial.pipe2 [
      (builtins.match "([[:digit:]]+) (red|green|blue)")
      (match: { "${(builtins.elemAt match 1)}" = (lib.strings.toInt (builtins.elemAt match 0)); })
    ]))
    (builtins.foldl' (acc : elem: acc // elem) { red = 0; green = 0; blue = 0;})
  ];

  parseGame = line:
    let
      matches = builtins.match "Game ([[:digit:]]+):[[:space:]](.*)" line;
      gameId = lib.strings.toInt (builtins.head matches);
      roundsStrs = lib.strings.splitString "; " (lib.last matches);
      rounds = map parseRound roundsStrs;
    in
      { inherit gameId rounds; };

  maxCubes = lib.foldl'
    (acc: round: {
      red = lib.max acc.red round.red;
      green = lib.max acc.green round.green;
      blue = lib.max acc.blue round.blue;
    })
    { red = 0; green = 0; blue = 0; };

  gamePossible = available: game:
    let
      max = maxCubes game.rounds;
    in
      max.red <= available.red && max.green <= available.green && max.blue <= available.blue;

  powerOfGame = game:
    let
      max = maxCubes game.rounds;
    in
      max.red * max.green * max.blue;
in
{
  part1 = lib.pipe ./inputs/day_2.txt [
    files.readLines
    (map parseGame)
    (builtins.filter (gamePossible { red = 12; green = 13; blue = 14; }))
    (map (game: game.gameId))
    sumInts
  ];

  part2 = lib.pipe ./inputs/day_2.txt [
    files.readLines
    (map parseGame)
    (map powerOfGame)
    sumInts
  ];
}
