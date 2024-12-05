{ stdenv, go }:
  stdenv.mkDerivation {
    name = "advent-of-code-2024-day04";
    src = ./src;

    buildInputs = [
      go
    ];

    buildPhase = ''
      GOCACHE=$PWD/cache go build -o out/day04 $src/day04.go

    '';

    installPhase = ''
      mkdir -p $out/bin
      cp out/day04 $out/bin/day04
    '';
  }
