library(tidyverse)
library(ggplot2)

# 数据生成
set.seed(123)
medical <- data.frame(
  id = 1:100,
  age = round(runif(100, 20, 80)),
  sbp = round(rnorm(100, 120, 20)),
  dbp = round(rnorm(100, 80, 10)),
  glucose = round(rnorm(100, 5.5, 1), 1),
  gender = sample(c("Male", "Female"), 100, replace=TRUE),
  disease = sample(c("Yes", "No"), 100, replace=TRUE)
)

# 绘制直方图与密度图
ggplot(medical, aes(x = glucose)) + 
  geom_histogram(binwidth = 0.5, fill = 'lightblue', color = 'black') +
  # geom_density(aes(y = 0.5*..count..), color="red") 过时
  geom_density(aes(y = 0.5*after_stat(count)), color="red")
