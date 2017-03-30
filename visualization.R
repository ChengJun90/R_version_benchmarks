library("ggplot2")
library("readr")
library("dplyr")
library("stringr")

setwd("F:/ProjectR")

bm1 <- read_csv("mro3.3.2.csv")
bm2 <- read_csv("r3.3.3.csv")
bm3 <- read_csv("r3.4.0.csv")
bm <- bind_rows(bm1,bm2,bm3)

decomposition <- bm %>% filter(str_detect(expr,"decomposition"))
multiply <- bm %>% filter(str_detect(expr,"multiply"))
pca <- bm %>% filter(str_detect(expr,"pca"))
fib <- bm %>% filter(str_detect(expr,"fib"))
sortperf <- bm %>% filter(str_detect(expr,"sortperf"))
df <- bm %>% filter(str_detect(expr,"sortperf"))
regression <- bm %>% filter(str_detect(expr,"regression"))

bm %>% group_by(expr,info) %>% 
  summarise(mean=mean(time),median=median(time)) %>% 
  arrange(expr,-desc(mean)) %>% 
  print(.,n=dim(.)[1])


for (i in c("decomposition","multiply","pca","fib","sortperf","df","regression")) {
  obi <- eval(parse(text=i))
  ggplot(obi,aes(x=time,color=info)) +
    geom_density(adjust=0.3) +
    scale_x_continuous(limits = c(min(obi$time),quantile(obi$time,probs=0.95)))+
    theme_classic()+
    labs(title = i)
  ggsave(paste(i,".png",sep=""), width = 7, height = 5)
}