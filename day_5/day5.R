library('stringr')

text <- 'dabAcCaCBAcCcaDA'
filename = '~/GitHub/AoC_2018/day_5/in.txt'
fo <- file(filename, open='r')
text <- readLines(fo) #50k char
close(fo)

# part I
reg <- regex('([:alpha:])(?!\\1)(?i:\\1)', ignore_case=FALSE)
print(nchar(polymer.react(text, reg)))

# part II
variants <- compare.polymers(text, reg)
print(variants[which(variants == min(variants))])

polymer.react <- function(text, reg) {
    newstr <- str_remove_all(text, reg)
    if (newstr == text) return(text)
    else return(polymer.react(newstr, reg))
}

compare.polymers <- function(text, reg) {
    return(vapply(letters, FUN=function(i) {
        ch.rm <- paste0('[',i,'|',toupper(i),']')
        str.rm <- str_remove_all(text, ch.rm)
        return(nchar(polymer.react(str.rm, reg)))
    }, FUN.VALUE = numeric(1)))
}