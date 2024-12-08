{ stdenv, jdk23 }:
  stdenv.mkDerivation {
    name = "advent-of-code-2024-day07";
    src = ./src;

    buildInputs = [
      jdk23
    ];

    buildPhase = ''
      javac $src/day07.java -s out/day07
    ''

    installPhase = ''
      mkdir -p $out/bin
      cp $src/day06.lua $out/bin/day06
      chmod +x $out/bin/day06
    '';
  }
