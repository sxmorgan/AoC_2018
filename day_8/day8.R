
tree <- as.numeric(strsplit('2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2', ' ')[[1]])
tree <- as.numeric(strsplit('2 3 2 1 0 1 5 0 1 6 7 0 1 8 9 10 11', ' ')[[1]])
filename = '~/GitHub/AoC_2018/day_8/in.txt'
fo <- file(filename, open='r')
tree <- as.numeric(strsplit(readLines(fo),' ')[[1]])
close(fo)

cum.sum <<- 0

# part I
hnnngh(tree)
print(cum.sum)

hnnngh <- function(tree) {

    print('NEW ITERATION')
    print(tree)
    num.chil <- tree[1]
    num.meta <- tree[2]

    # BASE CASE - metadata reached
    if (num.chil == 0) {
        print('base case reached')
        print(tree[3:(2+num.meta)])
        meta.sum <- sum(tree[3:(2+num.meta)])
        print(paste('meta.sum',meta.sum))
        cum.sum <<- cum.sum + meta.sum
        print(cum.sum)}
    
    # ELSE - create child trees
    print(paste('calling hnnngh', num.chil, 'times'))
    for (i in seq_len(num.chil)) {
        tree <- as.numeric(na.omit(tree[3:length(tree)]))
        print(tree)
        hnnngh(tree)}
    
    #meta.sum <- sum(tree[1:num.meta])
    meta.sum <- sum(tree[1:num.meta])
    print(paste('meta.sum', meta.sum))
    cum.sum <<- cum.sum + meta.sum
    print(paste('end', cum.sum))
}