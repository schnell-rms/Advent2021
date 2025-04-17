import re
import numpy as np

from collections import defaultdict


def main(inputPath):

    map=defaultdict(int)

    def checkLine(line):
        numbers = np.array([int(x) for x in re.findall(r"\d+", line)])
        if numbers[0]==numbers[2] or numbers[1] == numbers[3]:
            for i in range(min(numbers[0], numbers[2]), max(numbers[0], numbers[2]) + 1):
                for j in range(min(numbers[1], numbers[3]), max(numbers[1], numbers[3]) + 1):
                    # print(i, " <> ",j)
                    map[(i,j)] += 1

    with open(inputPath) as file:
        for line in file:
            checkLine(line)

    firstStar = sum([map[x] > 1 for x in map.keys()])
    print("First star: ", firstStar)

if __name__=="__main__":
    main("inputs/05.txt")