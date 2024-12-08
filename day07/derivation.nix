{ stdenv, jdk23 }:
  stdenv.mkDerivation {
    name = "advent-of-code-2024-day07";
    src = ./src;

    buildInputs = [
      jdk23
    ];

    buildPhase = ''
      javac $src/day07.java
    ''

    installPhase = ''
      mkdir -p $out/{bin,share}
      cp *.class $out/share

      cat <<EOF > $out/bin/day07
      #!/bin/sh
      "${jdk23.outPath}/bin/java" -classpath "\$(dirname "\$0")/../share" day07 "\$@"
      EOF

      chmod +x $out/bin/day07
    '';
  }
