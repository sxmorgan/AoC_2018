library('stringr')

text <- 'dabAcCaCBAcCcaDA'
filename = '~/GitHub/AoC_2018/day_5/in.txt'
fo <- file(filename, open='r')
text <- readLines(fo) #50k char
close(fo)

reg <- regex('(.+?)\\1', ignore_case=TRUE)
locs <- prune.locs(as.data.frame(str_locate_all(text, reg)))
# chars <- str_sub(text, locs$start, locs$end)
# chars <- chars[which(nchar(chars) == 2)]
# locs <- locs[which(nchar(chars) == 2),]
# locs$polarized <- vapply(seq_along(nrow(locs)), FUN=function(x) {
#     return(case.check(chars[as.numeric(x)]))}, FUN.VALUE = logical(1))
# locs <- locs[which(locs$polarized == TRUE),]
# chars <- chars[which(locs$polarized == TRUE)]

print(polymer.react(text, locs, reg))

polymer.react <- function(text, locs, reg) {
    
    if (nrow(locs) == 0) return(text)
    else {
        chars <- str_sub(text, locs$start, locs$end)
        locs$polarized <- vapply(seq_along(nrow(locs)), FUN=function(x) {
            return(case.check(chars[as.numeric(x)]))}, FUN.VALUE = logical(1))
        locs <- locs[which(locs$polarized == TRUE),]
        
        newstr <- remove.chars(text, locs)
        print(paste('new text length',nchar(newstr)))
        newlocs <- prune.locs(as.data.frame(str_locate_all(newstr, reg)))
        # chars <- str_sub(newstr, locs$start, locs$end)
        # locs$polarized <- vapply(seq_along(nrow(locs)), FUN=function(x) {
        #     return(case.check(chars[as.numeric(x)]))}, FUN.VALUE = logical(1))
        # locs <- locs[which(locs$polarized == TRUE),]
        # chars <- chars[which(locs$polarized == TRUE)]
        return(polymer.react(newstr, newlocs, reg))}
}

# returns boolean vector 
case.check <- function(ch) {
    if (nchar(ch) > 2) return(FALSE)
    else {
        ch1 = substr(ch,1,1)
        ch2 = substr(ch,2,2)
        if (ch1 == ch2) return(FALSE)
        else if (toupper(ch1) == toupper(ch2)) return(TRUE)
        else return(FALSE)}
}

# returns df with locations of matches > length 2 removed
prune.locs <- function(locs) {
    return(locs[which((locs$end - locs$start) == 1),])
}

# returns new string with text 
remove.chars <- function(text, locs) {
    return(paste(strsplit(text, 
                          substr(text, 
                                 locs$start, 
                                 locs$end))[[1]], collapse=''))
}