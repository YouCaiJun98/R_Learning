# 散点图矩阵

## 基础散点图矩阵
library(tidyverse)  # 核心数据处理+绘图包
library(GGally)     # 专门绘制散点图矩阵的扩展包

mtcars_sub <- mtcars %>% 
  select(mpg, disp, hp, drat, wt)  # 精准选择你要的5个变量

ggpairs(mtcars_sub)

## 引入线性拟合的直线
mtcars_sub <- mtcars %>% select(mpg, disp, hp, drat, wt)

ggpairs(
  data = mtcars_sub,
  title = "mtcars 散点图矩阵（带线性拟合）",
  
  # 上三角：相关系数
  upper = list(continuous = "cor"),
  
  # 下三角：散点 + 线性拟合直线（关键！）
  lower = list(
    continuous = wrap(
      "smooth",       # 用 smooth = 散点 + 拟合线
      method = "lm",  # 线性回归拟合
      se = FALSE,     # 不显示置信区间（想显示改成 TRUE）
      alpha = 0.6,    # 点透明度
      size = 1.5,     # 点大小
      color = "#2E86AB"  # 点颜色
    )
  ),
  
  # 对角线：密度分布
  diag = list(continuous = wrap("densityDiag", fill = "#A23B72"))
) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))


# 相关图
mtcars_sub <- mtcars %>% select(mpg, disp, hp, drat, wt)

cor_matrix <- cor(mtcars_sub, method = "pearson")

cor_long <- cor_matrix %>%
  as.data.frame() %>%
  rownames_to_column("var1") %>%
  pivot_longer(-var1, names_to = "var2", values_to = "correlation")

ggplot(cor_long, aes(x = var1, y = var2, fill = correlation)) +
  geom_tile(color = "white", linewidth = 1) +  # 热图方块
  geom_text(aes(label = round(correlation, 2)), 
            color = "white", size = 5, fontface = "bold") +  # 显示相关系数数值
  scale_fill_gradient2(low = "#0072B2", mid = "white", high = "#D55E00",
                       midpoint = 0, limit = c(-1,1)) +  # 颜色：蓝(负) → 白(0) → 红(正)
  labs(title = "mtcars 变量皮尔逊相关系数热图",
       x = NULL, y = NULL, fill = "皮尔逊相关系数") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        axis.text = element_text(size = 11, face = "bold"),
        panel.grid = element_blank())

# 密度热图
set.seed(123)  # 固定随机结果，可复现
a <- rnorm(5000, 0, 1)
b <- rnorm(5000, 0, 3)

df <- tibble(a, b)

ggplot(df, aes(x = a, y = b)) +
  # 核心：用透明度+颜色深浅模拟密度效果
  geom_point(
    alpha = 0.3,    # 透明度，点越重叠颜色越深
    size = 1.2,     # 点大小，和你图匹配
    color = "#3182bd"  # 统一蓝色，和你图的色调一致
  ) +
  theme_minimal() +
  labs(x = "a", y = "b") +
  theme(
    axis.text = element_text(size = 12),
    axis.title = element_text(size = 14)
  )

# 函数图像
x <- seq(1, 100, length.out = 1000)

y <- log(x) + sqrt(x) + x^2

df <- tibble(x, y)

ggplot(df, aes(x = x, y = y)) +
  geom_line(linewidth = 1.2, color = "#2E86AB") +  # 平滑曲线
  labs(
    title = expression(y == log(x) + sqrt(x) + x^2),
    x = "x (1 ~ 100)",
    y = "y 值"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))


