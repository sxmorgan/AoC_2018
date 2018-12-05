import sys, itertools

def main(argv):

    # part I
    fo = open(argv[1])
    inlist = fo.read().splitlines()
    fo.close()
    print(sum([int(inlist[i]) for i in range(len(inlist))]))

    # part II
    print(find_dups(inlist))

def find_dups(inlist):
    freqs = set()
    freqs.add(0)
    i = 0
    freq = 0
    while i < len(inlist):
        freq = freq + int(inlist[i])
        if freq in freqs:
            return(freq)
        elif i == (len(inlist)-1):
            i = 0
        else:
            freqs.add(freq)
            i += 1
    return(None)

main(sys.argv)
