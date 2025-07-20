{ stdenv, clang }:
  stdenv.mkDerivation {
    name = "advent-of-code-2024-day08";
    src = ./src;

    buildInputs = [
      clang
    ];

    buildPhase = ''
      clang $src/day08.c -O3 -ffast-math -o day08
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp day08 $out/bin/day08

      chmod +x $out/bin/day08
    '';
  }
