<!-- Automatically generated from README.md.gyb, do not edit directly! -->

# Advent of Code 2024

[![Run](https://github.com/Magi3r/AoC-2024/actions/workflows/run.yml/badge.svg)](https://github.com/Magi3r/AoC-2024/actions/workflows/run.yml)

My solutions to the [Advent of Code 2024](https://adventofcode.com/2024).

- [x] [**Day 01**](day01): [Python](day01/src/day01.py)
- [x] [**Day 02**](day02): [Rust](day02/src/day02.py)
- [x] [**Day 03**](day03): [DDP](day03/src/day03.ddp)

## Development

The programs are packaged with [Nix](https://nixos.org/), a functional package manager for Linux and macOS that focuses on reproducible builds. This makes it easy to build the programs, both locally and CI, without relying on system packages.

To build one of the days, `cd` into the corresponding directory and build and/or run the Nix flake. For example, to run day 1, use the following commands:

```sh
cd day01
nix run . resources/input.txt
```

Every day is packaged up to take exactly one command-line argument, the input file, and usually includes the demo input from the exercise too.

> [!TIP]
> The build environment can be added to the current `PATH` using `nix develop`. This is useful to manually run the compiler.

## Previous Years

My solutions to the previous challenges can be found here:

- [Advent of Code 2023](https://github.com/Magi3r/AoC-2023)