# this piece of code demonstrates how using lists to concatenate data is faster than using DFs
# from Hadley, 2nd edition of “Advanced R” (https://adv-r.hadley.nz/)
library(microbenchmark)
x <- data.frame(matrix(runif(5 * 1e4), ncol = 5))
medians <- vapply(x, median, numeric(1))

method1 <- function(){
# cat(tracemem(x), "\n")
#> <0x7f80c429e020>

    for (i in 1:5) {
      x[[i]] <- x[[i]] - medians[[i]]
    }
}

y <- as.list(x)

# cat(tracemem(y), "\n")
#> <0x7f80c5c3de20>
method2 <- function(){
    for (i in 1:5) {
      y[[i]] <- y[[i]] - medians[[i]]
    }
}
#> tracemem[0x7f80c5c3de20 -> 0x7f80c48de210]:
obj <- microbenchmark(method1(), method2(), times = 20000, unit = "s")
(test <- obj %>% group_by(expr) %>% summarise(something = mean(time)))
