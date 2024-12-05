package main

import (
	"log"
	"fmt"
	"bufio"
	"os"
)

func prepare() []string {
	path := os.Args[1]

	file, err := os.Open(path)
	if err != nil {
        log.Fatal(err)
    }
    defer file.Close()

    scanner := bufio.NewScanner(file)
    input := []string {}
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
	result := 0
	for y_i,y := range input {
		for x_i,x := range y {
			if x == 'X' {
				result += find_valid_1(input, x_i, y_i)
				log.Print(result)			}
		}

	}
	return result
}

func find_valid_1(input []string, x int, y int) int {
	result := 0
	move_directions := [3]int {-1,0,1}
	for _, x_move := range move_directions {
		for _, y_move := range move_directions {
			if is_valid_1(input, 'M', x, y, x_move, y_move) {
				result +=  1
			}
		}
	}
	return result
}

func is_valid_1 ( input []string, letter byte, x int, y int, x_move int, y_move int) (bool) {
	x +=x_move
	if x<0 || x>= len(input[0]) {
		return false
	}
	y += y_move
	if y<0 ||y>=len(input){
		return false
	}
	if input[y][x] == letter {
		if letter == 'M'{
			return is_valid_1(input, 'A', x,y,x_move, y_move)
		} else if letter == 'A' {
			return is_valid_1(input, 'S', x,y,x_move, y_move)
		} else {
log.Print("Found valid. x: ", x, "y: ",y, "x_move: ", x_move, "y_move: ", y_move)
			return true
		}
	}
	return false

}


func is_valid_2(input []string, x int, y int) bool {
	list := make(map[byte][]int)
	for x_move := range {-1,1} {
		x_pos:= x+x_move
		if (x_pos <0 or x_pos >= len(input[0]) {
			return false
		}
		for y_move := range {-1,1} {
			y_pos := y+y_move
			if y_pos <0 or y_pos >= len(input) { return false}

			if input[y_pos][x_pos] == 'M' or input[y_pos][x_pos] =='S' {
				append(list[x_pos],[y_pos])
			} else {
				return false
			}
		}
	}
	if len(list['M']) != 2 {
		return false
	}
	if (list['M'][0][0] == list['M'][1][0]) or (list['M'][0][1]==list['M'][1][1]){
		return true
	}
	return false
	
}


func part2(input []string) int {
	return 0
}
