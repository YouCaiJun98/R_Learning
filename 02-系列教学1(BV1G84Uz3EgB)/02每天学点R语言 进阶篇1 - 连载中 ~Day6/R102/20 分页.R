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

# 图像分页
ggplot(medical, aes(x = age, y = sbp)) +
  geom_point() + 
  facet_wrap(~ gender)

# facet_grid例子
medical_data <- data.frame(
  年龄 = sample(30:80, 300, replace = TRUE),
  血糖值 = c(
    rnorm(100, 5.2, 0.6),   # 健康组
    rnorm(100, 8.5, 1.2),   # 糖尿病组
    rnorm(100, 6.8, 0.9)    # 高血压组
  ),
  性别 = rep(c("男性","女性"), 150),
  患病分组 = rep(c("健康","糖尿病","高血压"), each = 100)
)

# 2. facet_grid 医学分面绘图
ggplot(medical_data, aes(x = 年龄, y = 血糖值)) +
  geom_point(color = "#E74C3C", alpha = 0.6, size = 1.5) +
  # 核心：行=性别，列=患病分组，二维临床对照
  facet_grid(性别 ~ 患病分组, scales = "free") +
  # 临床图表标注
  labs(
    title = "不同性别+疾病分组：年龄与空腹血糖分布",
    x = "患者年龄（岁）",
    y = "空腹血糖值（mmol/L）",
    caption = "模拟临床回顾性分析数据"
  ) +
  theme_bw(base_size = 11)
