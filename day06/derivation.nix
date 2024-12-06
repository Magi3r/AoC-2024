{ stdenv, lua }:
  stdenv.mkDerivation {
    name = "advent-of-code-2024-day06";
    src = ./src;

    buildInputs = [
      lua
    ];

    installPhase = ''
      mkdir -p $out/bin
      cp $src/day06.lua $out/bin/day06
      chmod +x $out/bin/day06
    '';
  }
