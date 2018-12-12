
indata <- cbind(c(1,1,8,3,5,8), c(1,6,3,4,5,9)) # col, row !
# indata <- read.csv('~/GitHub/AoC_2018/day_6/in.csv')

markers <- c(LETTERS, paste0(LETTERS, LETTERS))[1:nrow(indata)]
rownames(indata)

grid.view <- matrix(NA, nrow = max(indata[,2])+1, ncol = max(indata[,1]+1))
for (i in 1:nrow(indata)) {grid.view[indata[i,2], indata[i,1]] <- markers[i]}

grid.view <- cbind(vapply(ncol(grid.view), FUN=function(c, coords){
    col.coords <- 
    dts <- dist(grid.view[,c], coords)
}, FUN.VALUE = character(1), coords=indata))