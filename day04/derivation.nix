{ stdenv, go }:
  stdenv.mkDerivation {
    name = "advent-of-code-2024-day04";
    src = ./src;

    buildInputs = [
      go
    ];

    buildPhase = ''
      cd $src
      go build 
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp $src/day04 $out/bin/day04
      chmod +x $out/bin/day04
    '';
  }
