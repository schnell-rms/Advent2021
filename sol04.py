
import re

from functools import reduce

def getAllNumbers(line):
    out = [int(x) for x in re.findall(r"\d+", line)]
    return out

class BingoTable():

    def __init__(self):
        self.numbers=[]
        self.isAlreadyWin = False

    def addLine(self, line):
        self.numbers.append(getAllNumbers(line))
        pass

    def setNumber(self, n):
        for line in self.numbers:
            if n in line:
                idx = line.index(n)
                # 0 could be a number, but as eventually we do an addition, it does not matter
                # A variant would be to replace with None the marked numbers
                line[idx] = -line[idx]
                return True
        return False

    def isDone(self):
        if self.isAlreadyWin:
            return True

        # Check lines:
        for line in self.numbers:
            isLineMarked = reduce(lambda x,y: x and (y<0), line, True)
            if isLineMarked:
                self.isAlreadyWin = True
                return True

        # Check columns:
        m = len(self.numbers[0])
        for i in range(m):
            isColumnMarked = reduce(lambda x, line: x and line[i]<0, self.numbers, True)
            if isColumnMarked:
                self.isAlreadyWin = True
                return True

        return False

    def sumOfNotMarked(self):
        return sum([sum([x for x in line if x > 0]) for line in self.numbers])

    def isEmpty(self):
        return not self.numbers

    def print(self):
        for line in self.numbers:
            print(line)
        print()

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
        print("need to pop")
        bingos.pop()

    first_sol = None
    last_sol = None

    for n in numbers:
        all_done = True
        for b in bingos:
            if b.isDone():
                continue

            if b.setNumber(n) and b.isDone():
                notMarkedSum = b.sumOfNotMarked()
                if first_sol == None:
                    first_sol = n * notMarkedSum
                last_sol = n * notMarkedSum
            else:
                all_done = False

        if all_done:
            break

    print("First star:", first_sol)
    print("Second star:", last_sol)

if __name__ == "__main__":
    main()
