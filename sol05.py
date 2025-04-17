import re
import numpy as np

from collections import defaultdict

import argparse


def sol1(inputPath, is_verbose):
    map=defaultdict(int)

    def checkLine(line):
        numbers = np.array([int(x) for x in re.findall(r"\d+", line)])
        if numbers[0]==numbers[2] or numbers[1] == numbers[3]:
            for i in range(min(numbers[0], numbers[2]), max(numbers[0], numbers[2]) + 1):
                for j in range(min(numbers[1], numbers[3]), max(numbers[1], numbers[3]) + 1):
                    if is_verbose:
                        print(i, " <> ",j)
                    map[(i,j)] += 1

    with open(inputPath) as file:
        for line in file:
            checkLine(line)

    firstStar = sum([map[x] > 1 for x in map.keys()])
    print("First star: ", firstStar)

def sol2(inputPath, is_verbose):
    map=defaultdict(int)

    def checkLine(line):
        numbers = np.array([int(x) for x in re.findall(r"\d+", line)])
        step_row = 1 if numbers[0]<numbers[2] else 0 if numbers[0]==numbers[2] else -1
        step_col = 1 if numbers[1]<numbers[3] else 0 if numbers[1]==numbers[3] else -1
        assert(numbers[0]==numbers[2] or numbers[1] == numbers[3] or abs(numbers[0]-numbers[2]) == abs(numbers[1]-numbers[3]))

        i = numbers[0]
        j = numbers[1]

        while (i != numbers[2] or j != numbers[3]):
            map[(i,j)] += 1
            if is_verbose:
                print(i, " <> ",j)
            i += step_row
            j += step_col

        map[(i,j)] += 1
        if is_verbose:
            print(i, " <> ",j)
        assert(j==numbers[3])

    with open(inputPath) as file:
        for line in file:
            checkLine(line)

    secondStar = sum([map[x] > 1 for x in map.keys()])
    print("Second star: ", secondStar)

if __name__=="__main__":
    parser = argparse.ArgumentParser("AoC 2021 Day05")
    parser.add_argument("-s", "--sample", help="Use the sample input.", action="store_true")
    parser.add_argument("-v", "--verbose", help="Print the added coordinates.", action="store_true")
    args = parser.parse_args()

    finput = "inputs/05Sample.txt" if args.sample else "inputs/05.txt"

    sol1(finput, args.verbose)
    sol2(finput, args.verbose)
