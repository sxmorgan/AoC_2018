import sys
from itertools import groupby

def main(argv):

    fo = open(argv[1])
    inlist = fo.read().splitlines()
    fo.close()

    # part I
    print(checksum(inlist, 2) * checksum(inlist, 3))

    # part II
    print(find_boxes(inlist))

def checksum(inlist, num):
    counts = 0
    for s in range(len(inlist)):
        sortstr = ''.join(sorted(inlist[s]))
        temp = [list(g) for k,g in groupby(sortstr)]
        lengths = [len(l) for l in temp]
        if lengths.count(num) > 0:
            counts += 1
    return(counts)

def find_boxes(inlist):
    for i in range(len(inlist)):
        s1 = list(enumerate(inlist[i]))

        for j in range(len(inlist[1:])):
            s2 = list(enumerate(inlist[j]))
            shared = set(s1) & set(s2)

            if len(shared) == (len(s1)-1):
                temp = [tup[1] for tup in shared]
                return(inlist[i], inlist[j])

main(sys.argv)
