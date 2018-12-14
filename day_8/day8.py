import sys, re

def main(argv):
    infile = open(argv[1])
    inlist = infile.read().splitlines()
    infile.close()
    outfile = open('clean_table.csv','w+')

    for line in inlist:
        temp = line.split(']')
        outline = re.split('[[-]', re.sub('[\s]','-',temp[0]))[1:]
        outline.append(temp[1].lstrip())
        commas = map(lambda x:x+',', outline)
        outfile.writelines(commas)
        outfile.write('\n')
    outfile.close()

main(sys.argv)
