import sys, re

def main(argv):
    infile = open(argv[1])
    inlist = infile.read().splitlines()
    infile.close()
    outfile = open('clean_table.csv','w+')

    for line in inlist:
        temp = re.sub('[#@:]','', line)
        outline = re.split('\D', temp)
        del(outline[1]) # whitespace
        commas = map(lambda x:x+',', outline)
        outfile.writelines(commas)
        outfile.write('\n')

    outfile.close()

main(sys.argv)
