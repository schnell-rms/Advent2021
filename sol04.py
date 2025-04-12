
import re

from functools import reduce

def getAllNumbers(line):
    out = [int(x) for x in re.findall(r"\d+", line)]
    return out

class BingoTable():

    def __init__(self):
        self.numbers=[]

    def addLine(self, line):
        self.numbers.append(getAllNumbers(line))
        pass

    def setNumber(self, n):
        for line in self.numbers:
            if n in line:
                idx = line.index(n)
                line[idx] = -line[idx]
                return True
        return False

    def isDone(self):
        # Check lines:
        for line in self.numbers:
            isLineMarked = reduce(lambda x,y: x and (y<0), line, True)
            if isLineMarked:
                return True

        # Check columns:
        m = len(self.numbers[0])
        for i in range(m):
            isColumnMarked = reduce(lambda x, line: x and line[i]<0, self.numbers, True)
            if isColumnMarked:
                return True

        return False

    def sumOfNotMarked(self):
        return sum([sum([x for x in line if x > 0]) for line in self.numbers])

    def isEmpty(self):
        return not self.numbers

def main():

    filePath = "./inputs/04.txt"

    file = open(filePath)
    numbers = getAllNumbers(file.readline())

    bingos = []

    while line:=file.readline():
        if line.isspace():
            bingos.append(BingoTable())
            continue

        bingos[-1].addLine(line)

    if bingos[-1].isEmpty():
        bingos.pop()

    first_sol = None

    for n in numbers:
        for b in bingos:
            if b.setNumber(n) and b.isDone():
                first_sol = n * b.sumOfNotMarked()
                break
        if first_sol:
            break

    print("First star:", first_sol)

if __name__ == "__main__":
    main()
