let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;

  # Like pipe but with arguments reversed
  # It's useful, trust me!
  pipe2 = funcs: arg: lib.pipe arg funcs;
in
{
  inherit pipe2;
}
