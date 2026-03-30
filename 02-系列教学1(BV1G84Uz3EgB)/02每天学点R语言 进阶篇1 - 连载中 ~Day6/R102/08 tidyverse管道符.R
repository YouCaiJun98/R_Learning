library(tidyverse)


# 管道符
# %>%

a <- 1:20
exp(log(sum(a)))
a %>% sum() %>% log() %>% exp()

# R语言原生管道符
a |> sum()
