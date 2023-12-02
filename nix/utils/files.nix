let
  strings = import ./strings.nix;

  readLines = path: strings.lines(builtins.readFile path);
in
{
  inherit readLines;
}
