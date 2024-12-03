{ stdenv, wget }:
  stdenv.mkDerivation {
    name = "advent-of-code-2024-day03";
    src = ./src;

    nativeBuildInputs = [
      wget
    ];

    buildPhase = ''
      wget https://github.com/DDP-Projekt/Kompilierer/releases/download/v0.5.0-alpha/DDP-v0.5.0-alpha-linux-amd64.tar.gz
      tar -xzf ./DDP-v0.5.0-alpha-linux-amd64.tar.gz
      mv ./DDP-v0.5.0-alpha-linux-amd64 ./DDP
      cd ./DDP
      ./ddp-setup --force
      cd ..
      cd $src
      kddp kompiliere day03.ddp
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp day03 $out/bin/day03
      chmod +x $out/bin/day03
    '';
  }