{ stdenv, python3 }:
  stdenv.mkDerivation {
    name = "advent-of-code-2024-day01";
    src = ./src;

    buildInputs = [
      python3
    ];

    installPhase = ''
      mkdir -p $out/bin
      cp $src/day01.py $out/bin/day01
      chmod +x $out/bin/day01
    '';
  }
