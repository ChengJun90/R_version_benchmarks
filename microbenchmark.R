library("microbenchmark")
setwd("F:/ProjectR")
set.seed (123)


# Matrix multiply
multiply <- function(m,n) {
  A <- matrix (runif (m*n),m,n)
  B <- crossprod(A)
  return(B)
}

# QR decomposition
decomposition <- function(m,n) {
  A <- matrix (runif (m*n),m,n)
  B <- qr(A)
  return(B)
}


# Principal Components Analysis
pca <- function(m,n) {
  A <- matrix (runif (m*n),m,n)
  B <- prcomp(A)
  return(B)
}


# fib
fib <- function(n) {
  if (n < 2) {
    return(n)
  } else {
    return(fib(n-1) + fib(n-2))
  }
}


# quicksort
qsort <- function(a) {
  qsort_kernel <- function(lo, hi) {
    i = lo
    j = hi
    while (i < hi) {
      pivot = a[floor((lo+hi)/2)]
      while (i <= j) {
        while (a[i] < pivot) i = i + 1
        while (a[j] > pivot) j = j - 1
        if (i <= j) {
          t = a[i]
          a[i] <<- a[j]
          a[j] <<- t
          i = i + 1;
          j = j - 1;
        }
      }
      if (lo < j) qsort_kernel(lo, j)
      lo = i
      j = hi
    }
  }
  qsort_kernel(1, length(a))
  return(a)
}


sortperf <- function(n) {
  v = runif(n)
  return(qsort(v))
}


# dataframe
df <- function(n) {
  dta <- data.frame(x1=runif(n),
                    x2=sample(c("呀","呵呵","哈哈哈"), size=n, replace=T),
                    x3=sample(letters,n,replace = T))
  summary(dta)
  dta <- dta[3:n,]
  dta <- dta[order(dta$x1),]
  dta[dta$x2=="呵呵" & dta$x1 > 0,]
  unique(dta, by = "x3")
  dta$x3 <- NULL
}

# regression
regression <- function(n) {
  matrix(rnorm(n*3),nrow=n,ncol=3)->.;
  lm(.[,1]~.[,2]*.[,3])->.;
  summary(.)
}

bm <- microbenchmark(multiply(100,100),
               decomposition(100,100),
               pca(100,100),
               fib(10),
               sortperf(100),
               df(1000),
               regression(1000),
               times = 1000L)
bm


# R version
bm$info <- "mro3.3.2"
write.csv(bm, file = "mro3.3.2.csv")
devtools::session_info()


# bm$info <- "r3.3.3"
# write.csv(bm, file = "r3.3.3.csv")
# devtools::session_info()

# bm$info <- "r3.4.0"
# write.csv(bm, file = "r3.4.0.csv")
# devtools::session_info()