let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;

  has_any_prefix = str: prefixes: builtins.head ((builtins.filter (prefix: lib.strings.hasPrefix prefix str) prefixes) ++ [null]);

  find_all = str: elements: offset:
    if offset < (lib.stringLength str) then
      let
        match = has_any_prefix (builtins.substring offset (-1) str) elements;
      in
        (if match != null then [{ inherit offset; text = match; }] else [])
          ++ find_all str elements (offset + 1)
    else
      [];

  lines = content: builtins.filter (l: l != "") (lib.strings.splitString "\n" content);
in
{
  inherit find_all lines;
}
