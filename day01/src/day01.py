#!/usr/bin/env python3

import sys

def prepare():
    file = sys.argv[1]
    content = []
    with open(file) as f:
        while line := f.readline():
            content.extend(line.split("   "))

    list1 = []
    list2 = []
    for i, c in enumerate(content):
        if i%2==1:
            list1.append(int(c))
        else:
            list2.append(int(c))
    return list1, list2

def part1():
    list1, list2 = prepare()
    result = 0
    for i in range(len(list1)):
        result += abs(sorted(list1)[i] - sorted(list2)[i])
    return result

def part2():
    list1, list2 = prepare()
    score = 0
    for i in list1:
        score += i*list2.count(i)
    return score

print("Part 1: ", part1())
print("Part 2: ", part2())