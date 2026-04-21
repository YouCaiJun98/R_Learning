library(tidyverse)
library(ggplot2)

# 数据生成
set.seed(123)
followup <- data.frame(
  time = 1:10,
  glucose = cumsum(rnorm(10, 0, 0.2)) + 5
)

# 绘制线图
ggplot(followup, aes(x = time, y = glucose)) + 
  geom_line() + 
  geom_point()
