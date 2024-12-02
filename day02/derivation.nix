{ stdenv, rustc }:
  stdenv.mkDerivation {
    name = "advent-of-code-2024-day02";
    src = ./src;

    nativeBuildInputs = [
      rustc
    ];

    buildPhase = ''
      mkdir -p out
      rustc -o out/day02 -C opt-level=3 day02.rs
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp out/day02 $out/bin/day02
    '';
  }