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

# 绘制箱线图
ggplot(medical, aes(x = disease, y = sbp, fill = disease)) + 
  geom_boxplot()

# 加标题
ggplot(medical, aes(x = disease, y = sbp, fill = disease)) + 
  geom_boxplot() + 
  labs(caption = "底部备注：仅用于教学示例") +
  theme(
    plot.caption = element_text(
      size = 10,        # 字号
      color = "gray50",  # 颜色
      hjust = 0,        # 0左对齐 / 0.5居中 / 1右对齐
      face = "italic"   # 斜体
    )
  )

# 绘制小提琴图
ggplot(medical, aes(x = disease, y = sbp, fill = disease)) + 
  geom_violin()
