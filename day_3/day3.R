
data <- read.csv('~/GitHub/AoC_2018/day_3/clean_table.csv', header=FALSE)[,-6]
colnames(data) <- c('ID','FromLeft','FromTop','Width','Height')
cloth <- matrix(NA, nrow = 1000, ncol = 1000)

for (i in 1:nrow(data)) {
    cidx <- data[i,2]+1 
    ridx <- data[i,3]+1

    for (row in seq(ridx, ridx + data[i,5] - 1, 1)) {
        
        for (col in seq(cidx, cidx + data[i,4] - 1, 1)){
            
            if (is.na(cloth[row, col])) {cloth[row, col] <- data[i,1]}
            else {cloth[row, col] <- 0}}}}

# part I
cut_cloth <- table(cloth)
print(cut_cloth[names(cut_cloth) == 0])

areas <- data[,4]*data[,5]
names(areas) <- rownames(data)
overlap <- vapply(rownames(data), FUN=function(i) {
    counts <- cut_cloth[which(names(table(cloth))==data[i,1])]
    area <- areas[i]
    if (length(counts) == 0) {
        return(TRUE)}
    else if (counts != area) {
        return(TRUE)}
    else {return(FALSE)}
}, FUN.VALUE = logical(1))
data$Overlap <- overlap

# part II
print(data[which(data$Overlap == FALSE),1])

