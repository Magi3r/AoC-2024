{ stdenv, ruby }:
  stdenv.mkDerivation {
    name = "advent-of-code-2024-day05";
    src = ./src;

    buildInputs = [
      ruby
    ];

    installPhase = ''
      mkdir -p $out/bin
      cp $src/day05.rb $out/bin/day05
      chmod +x $out/bin/day05
    '';
  }
