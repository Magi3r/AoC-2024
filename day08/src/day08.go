package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"slices"

	euclid "github.com/OhYee/crypto/GF/euclid"
)

type Vec2 struct {
	x int
	y int
}

func prepare() []string {
	path := os.Args[1]

	file, err := os.Open(path)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	input := []string{}
	for scanner.Scan() {
		input = append(input, scanner.Text())
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
	return input

}

func main() {
	input := prepare()
	fmt.Println("Part 1: ", part1(input))
	fmt.Println("Part 2: ", part2(input))
}

func part1(input []string) int {
	location_map := make(map[string][]Vec2)
	for y_i, y := range input {
		for x_i, x := range y {
			if x != '.' {
				location_map[string(x)] = append(location_map[string(x)], Vec2{x_i, y_i})
			}
		}
	}

	positions := []Vec2{}
	for _, value := range location_map {
		if len(value) > 1 {
			for _, position1 := range value {
				for _, position2 := range value {
					if position1 != position2 {
						direction := Vec2{position2.x - position1.x, position2.y - position1.y}
						new_position := Vec2{position2.x + direction.x, position2.y + direction.y}
						if new_position.x >= 0 && new_position.x < len(input[0]) && new_position.y >= 0 && new_position.y < len(input) {
							if !slices.Contains(positions, new_position) {
								positions = append(positions, new_position)
							}
						}
					}
				}
			}
		}
	}

	return len(positions)
}

func part2(input []string) int {
	location_map := make(map[string][]Vec2)
	for y_i, y := range input {
		for x_i, x := range y {
			if x != '.' {
				location_map[string(x)] = append(location_map[string(x)], Vec2{x_i, y_i})
			}
		}
	}

	positions := []Vec2{}
	for _, value := range location_map {
		if len(value) > 1 {
			for _, position1 := range value {
				for _, position2 := range value {
					if position1 != position2 {
						direction := Vec2{position2.x - position1.x, position2.y - position1.y}
						direction = Vec2{direction.x / euclid.GCD(direction.x, direction.y, euclid.Plus, euclid.Multiplus, euclid.Divide), direction.y / euclid.GCD(direction.x, direction.y, euclid.Plus, euclid.Multiplus, euclid.Divide)}
						new_position := Vec2{position2.x + direction.x, position2.y + direction.y}
						x := 1
						for new_position.x >= 0 && new_position.x < len(input[0]) && new_position.y >= 0 && new_position.y < len(input) {
							if !slices.Contains(positions, new_position) {
								positions = append(positions, new_position)
							}
							x++
							new_position = Vec2{position2.x + direction.x*x, position2.y + direction.y*x}
						}
						new_position = Vec2{position2.x + direction.x, position2.y + direction.y}
						x = 0
						for new_position.x >= 0 && new_position.x < len(input[0]) && new_position.y >= 0 && new_position.y < len(input) {
							if !slices.Contains(positions, new_position) {
								positions = append(positions, new_position)
							}
							x--
							new_position = Vec2{position2.x + direction.x*x, position2.y + direction.y*x}
						}
					}
				}
			}
		} else {
			if !slices.Contains(positions, value[0]) {
				positions = append(positions, value[0])
			}
		}
	}
	// debug
	a := make([]string, len(input))
	copy(a, input)
	for _, position := range positions {
		if a[position.y][position.x] == '.' {
			a[position.y] = a[position.y][:position.x] + "#" + a[position.y][position.x+1:]
		}
	}
	for _, y := range a {
		log.Default().Println(y)
	}
	return len(positions)
}
