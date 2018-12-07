# part I
data <- read.csv('~/GitHub/AoC_2018/day_3/clean_table_test.csv', header=FALSE)[,-6]
colnames(data) <- c('Request','FromLeft','FromTop','Width','Height')
cloth <- matrix(NA, nrow = 8, ncol = 8)

for (i in 1:nrow(data)) {
    #print(data[i,])
    cidx <- data[i,2]+1 
    ridx <- data[i,3]+1
    for (row in seq(ridx, ridx + data[i,5] - 1, 1)) {
        for (col in seq(cidx, cidx + data[i,4] - 1, 1)){
            if (is.na(cloth[row, col])) {cloth[row, col] <- 0}
            else {cloth[row, col] <- 1}}}}

cut_cloth <- table(cloth)
print(cut_cloth[names(cut_cloth) == 1])