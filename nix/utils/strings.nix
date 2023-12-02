let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;

  matchAnyPrefix = str: prefixes: builtins.head ((builtins.filter (prefix: lib.strings.hasPrefix prefix str) prefixes) ++ [null]);

  findAll = str: elements: offset:
    if offset < (lib.stringLength str) then
      let
        match = matchAnyPrefix (builtins.substring offset (-1) str) elements;
      in
        (if match != null then [{ inherit offset; text = match; }] else [])
          ++ findAll str elements (offset + 1)
    else
      [];

  lines = content: builtins.filter (l: l != "") (lib.strings.splitString "\n" content);
in
{
  inherit findAll lines;
}
