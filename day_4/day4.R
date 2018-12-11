library('stringr')

# read infile and mash into data frame
filename = '~/GitHub/AoC_2018/day_4/in.txt'
fo <- file(filename, open='r')
text <- readLines(fo)
close(fo)
df <- t(as.data.frame(lapply(text, FUN=function(e){return(str_split(e,']'))[1]})))
df[,1] <- substring(df[,1], 2, nchar(df[,1])) 
df <- df[order(df[,1]),]
sorted <- data.frame(t(as.data.frame(str_split(df[,1], ' '))), df[,2])
rownames(sorted) <- seq_len(nrow(sorted))
colnames(sorted) <- c('date','time','action')
print(head(sorted))

# parse table for IDs & encode awake/asleep
idx <- grepl('#', sorted$action)
sorted$action <- as.character(sorted$action)
for (i in 1:nrow(sorted)) {
    if (idx[i] == TRUE) {
        sorted[i,'ID'] <- as.numeric(str_extract(sorted[i,'action'], '[0-9]+'))}
    else {
        sorted[i,'ID'] <- IDs[i-1]
        if (length(grep('asleep', sorted[i,'action']) == 1)) sorted[i,'action'] <- 1
        else sorted[i,'action'] <- 0}}
sorted <- sorted[!idx,] # remove shift msg
sorted$date <- as.character(sorted$date)
sorted$time <- as.character(sorted$time)
sorted$action <- as.numeric(sorted$action)
rownames(sorted) <- seq_len()
print(head(sorted))

# create new data frame for minutes
temp <- unique(sorted$date)
minutes = data.frame(date = temp, ID = sorted[match(temp, sorted$date), 'ID'],
                     matrix(0, nrow = length(temp), ncol = 60))
colnames(minutes)[3:ncol(minutes)] <- seq(0,59,1)
print(head(minutes))

# fill it
for (i in 1:nrow(sorted)){
    if (sorted[i,'action'] == 1) {
        start <- as.numeric(str_split(as.character.Date(sorted[i,'time']), ':')[[1]][2])+3
        stop <- as.numeric(str_split(as.character.Date(sorted[i+1,'time']), ':')[[1]][2])+2
        row.idx <- match(sorted[i,'date'], minutes[,'date'])
        minutes[row.idx, start:stop] <- 1}}

# find dat guard
minutes$rowsums <- rowSums(minutes[,-c(1,2)])
guard.totals <- vapply(unique(minutes$ID), FUN=function(i){
    idx <- which(minutes$ID == i)
    return(sum(minutes[idx, 'total']))}, FUN.VALUE = numeric(1))
names(guard.totals) <- unique(minutes$ID)
max.sleep <- max(guard.totals[-length(guard.totals)])
guard <- as.numeric(names(guard.totals)[which(guard.totals == max.sleep)])
idx <- which(minutes$ID == as.numeric(guard))
colsums <- as.numeric(colSums(minutes[idx,-c(1,2)]))
max.min <- max(colsums[-length(colsums)])
minute <- which(colsums == max.min)-1
print(guard * minute)

