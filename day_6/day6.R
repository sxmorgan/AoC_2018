
indata <- cbind(c(1,1,8,3,5,8), c(1,6,3,4,5,9)) # col, row !
indata <- read.csv('~/GitHub/AoC_2018/day_6/in.csv', header=FALSE)

markers <- c(LETTERS, paste0(LETTERS, LETTERS))[1:nrow(indata)]
rownames(indata) <- markers

grid.view <- matrix(NA, nrow = max(indata[,2])+1, ncol = max(indata[,1]+1))
for (i in 1:nrow(indata)) {grid.view[indata[i,2], indata[i,1]] <- markers[i]}

# part I
grid.filled <- fill.grid(indata, grid.view)
areas <- find.area(grid.filled)
letter <- names(areas)[which(areas==max(areas))]
print(max(areas) + areas[toupper(letter)])


# part II
grid.bool <- total.distance(indata, grid.view, 10000)
print(table(grid.bool))

fill.grid <- function(coords, grid.view) {
   
    for (row in 1:nrow(grid.view)) {
        for (col in 1:ncol(grid.view)) {
            if (is.na(grid.view[row, col])) {
                d.mat <- as.matrix(dist(rbind(coords, c(col, row)), 
                                        method = 'manhattan'))
                dists <- d.mat[nrow(d.mat),-ncol(d.mat)]
                nearest <- tolower(names(dists[which(dists==min(dists))]))
                #print(paste(row, col, nearest))
                if (length(nearest) > 1) grid.view[row, col] <- '.'
                else grid.view[row, col] <- nearest
            }
        }
    }
    
    return(grid.view)
}

find.area <- function(grid.filled) {
 
    counts <- table(grid.filled)
    edges <- unique(c(unique(grid.filled[1,]), unique(grid.filled[nrow(grid.filled),]),
                      unique(grid.filled[,1]), unique(grid.filled[,ncol(grid.filled)])))
    options <- subset(counts, !(names(counts) %in% edges))
    return(options)
}

total.distance <- function(coords, grid.view, limit) {
    
    for (row in 1:nrow(grid.view)) {
        for (col in 1:ncol(grid.view)) {
            tot.dist <- sum(abs(row-coords[,2]), abs(col-coords[,1]))
            if (tot.dist < limit) grid.view[row, col] <- TRUE
            else grid.view[row, col] <- FALSE
        }
    }
    
    return(grid.view)
}