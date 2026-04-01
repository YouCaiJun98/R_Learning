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

# 绘制散点图（含颜色修改）
## 方式1：在坐标轴里设置
medical %>% ggplot(aes(x = age, y = sbp, color=gender)) +
  geom_point()

## 方式2 - 按图控制：
medical %>% ggplot(aes(x = age, y = sbp)) +
  geom_point(aes(color=gender))
## 方式2补充 - 当然，也可以直接设置颜色：
medical %>% ggplot(aes(x = age, y = sbp)) +
  geom_point(color="red")

# 补充：根据变量设置颜色
my_color <- c(
  "Male"   = "#E74C3C",   # 红
  "Female" = "#3498DB"    # 蓝
)
medical %>% ggplot(aes(x = age, y = sbp, color=gender)) +
  geom_point() + 
  scale_color_manual(values = my_color)

