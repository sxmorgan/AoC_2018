import sys, numpy as np
from scipy.spatial import distance

def main(argv):
    indata = np.genfromtxt(argv[1], delimiter=',', dtype=int)
    indata = np.array([[1,1],[1,6],[8,3],[3,4],[5,5],[8,9]], dtype=int)
    print(indata)
    print(indata[...,1])
    print(indata.shape[1])
    print(max(indata[...,0]))
    #gridview = np.char.array(shape=(max(indata[...,0]), max(indata[...,1])))
    #print(gridview.shape)
    rows = 0:max(indata[...,1])
    don't need to initialize...


main(sys.argv)
