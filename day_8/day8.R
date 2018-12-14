
tree <- as.numeric(strsplit('2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2', ' ')[[1]])
tree <- as.numeric(strsplit('2 3 1 2 0 1 100 1 1 0 1 10 1 1 2', ' ')[[1]])
filename = '~/GitHub/AoC_2018/day_8/in.txt'
fo <- file(filename, open='r')
tree <- as.numeric(strsplit(readLines(fo),' ')[[1]])
close(fo)

# initialize structure with root info
thing <- list(tree = tree[3:length(tree)],  rem.children = tree[1],
              rem.meta = tree[2], cum.meta = 0)

# part I
print(hnnngh(thing))

hnnngh <- function(thing) {

    tree <- thing$tree
    i.children <- thing$tree[1]
    thing$rem.children <- thing$rem.children - 1 + i.children #update int
    #print('initial update of rem.children:')
    #print(tree)

    if (thing$rem.children == 0) # BASE CASE
        return(sum(thing$cum.meta, 
                   as.numeric(na.omit(tree[3:length(tree)]))))
    
    else { # WORK TOWARD BASE CASE
        i.metadata <- thing$tree[2]
        thing$rem.meta <- thing$rem.meta + i.metadata #update int
        
        # rest of tree is metadata - second base case...?
        if (thing$rem.meta == (length(tree) - 2)) { 
            return(sum(thing$cum.meta, 
                       as.numeric(na.omit(tree[3:length(tree)]))))}

        # next seq is metadata
        else if (i.children == 0) { 
            idx <- i.metadata + 2 #for next iteration
            thing$rem.meta <- thing$rem.meta - i.metadata
            thing$cum.meta <- thing$cum.meta + sum(tree[3:idx])
            thing$tree <- as.numeric(na.omit(tree[idx+1:length(tree)]))
            #print('0 children, metadata follows:')
            #print(thing)
        }
        
        # next seq is child
        else {
            thing$tree <- as.numeric(na.omit(tree[3:length(tree)]))
            #print('n children, child follows:')
            #print(thing)
            }
            
        return(hnnngh(thing))
    }
}