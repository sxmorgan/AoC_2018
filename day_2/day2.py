import sys
from itertools import groupby

def main(argv):

    # part I
    fo = open(argv[1])
    inlist = fo.read().splitlines()
    fo.close()

    print(checksum(inlist, 2) * checksum(inlist, 3))

def checksum(inlist, num):
    counts = 0
    for s in range(len(inlist)):
        sortstr = ''.join(sorted(inlist[s]))
        temp = [list(g) for k,g in groupby(sortstr)]
        lengths = [len(l) for l in temp]
        if lengths.count(num) > 0:
            counts += 1
    return(counts)

main(sys.argv)
