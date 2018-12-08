
data <- read.csv('~/GitHub/AoC_2018/day_3/clean_table.csv', header=FALSE)[,-6]
colnames(data) <- c('ID','FromLeft','FromTop','Width','Height')
cloth <- matrix(NA, nrow = 1000, ncol = 1000)

for (i in 1:nrow(data)) {
    cidx <- data[i,2]+1 
    ridx <- data[i,3]+1
    counter <- FALSE
    
    for (row in seq(ridx, ridx + data[i,5] - 1, 1)) {
        
        for (col in seq(cidx, cidx + data[i,4] - 1, 1)){
            
            if (is.na(cloth[row, col])) {
                cloth[row, col] <- data[i,1]}
            else {
                cloth[row, col] <- 0
                counter <- TRUE}}}
    
    data[i,'Overlap'] <- counter}

# check ID 1 eventually (would have no overlap...)

# part I
cut_cloth <- table(cloth)
print(cut_cloth[names(cut_cloth) == 0])

# part II
print(data[which(data$Overlap == FALSE),]) # TOO MANY, WHY!?

