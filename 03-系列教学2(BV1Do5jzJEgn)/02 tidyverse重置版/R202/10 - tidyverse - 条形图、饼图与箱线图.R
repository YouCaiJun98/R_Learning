library(tidyverse)

# 条形图
## 基础条形图
ggplot(mtcars, aes(x = factor(gear))) +  # factor 让它变成分类轴，更美观
  geom_bar(
    fill = "steelblue",  # 条形填充色
    color = "black",     # 边框
    alpha = 0.8          # 透明度
  ) +
  labs(
    title = "mtcars 各档位(gears)的样本数量",
    x = "档位 (Gears)",
    y = "样本数量 (Count)"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold")
  )

## 堆叠条形图
ggplot(mtcars, aes(x = factor(gear), fill = factor(vs))) +
  geom_bar(
    position = position_dodge(width = 0.8),  # 关键：让柱子并列
    color = "white",
    alpha = 0.85,
    width = 0.7, 
  ) +
  scale_fill_manual(
    values = c("dodgerblue", "tomato"),
    name = "VS (发动机类型)"
  ) +
  labs(
    title = "MTcars：不同档位(gears)的VS分组样本数量",
    x = "档位 (Gears)",
    y = "样本数量 (Count)"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    legend.position = "top"
  )

## 绘制颜色条形图
### 1. 自动筛选 colors() 中所有包含 red 的颜色
red_colors <- colors()[grep("red", colors())]

### 2. 构造数据，并且按颜色名排序（避免顺序混乱）
df <- tibble(
  color_name = factor(red_colors, levels = red_colors),  # 固定顺序
  value = 1
)

### 3. 水平条形图（修正版）
ggplot(df, aes(x = value, y = color_name)) +  # 关键：x是数值，y是颜色名
  geom_col(
    fill = red_colors,
    color = "white",
    linewidth = 0.5
  ) +
  scale_x_continuous(breaks = NULL) +  # 隐藏横坐标
  labs(
    title = "R colors() 中所有含 red 的颜色",
    x = NULL,
    y = "颜色名称"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    panel.grid = element_blank(),
    axis.text.y = element_text(size = 10)
  )


# 饼图
## 基础绘图
df <- tibble(
  group = letters[1:4],  # 标签 a, b, c, d
  value = 1:4            # 数值 1, 2, 3, 4
)

ggplot(df, aes(x = "", y = value, fill = group)) +
  geom_col(color = "white") +  # 柱子（白色边框分隔）
  coord_polar(theta = "y") +   # 关键：转换成饼图
  scale_fill_brewer(palette = "Set2") +  # 自动配色
  # 去掉多余坐标轴
  theme_void() +
  # 标题 + 图例
  labs(
    title = "饼图：a:d 对应数值 1:4",
    fill = "分组"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    legend.position = "right"
  )


## 改变饼图颜色（填色 + 边框）
df <- tibble(
  group = letters[1:4],  # a,b,c,d
  value = 1:4            # 1,2,3,4
)

ggplot(df, aes(x = "", y = value, fill = group)) +
  geom_col(color = "white", linewidth = 1) +  # 白色边框，线条粗细1
  coord_polar(theta = "y") +                  # 转换成饼图
  scale_fill_manual(values = rainbow(4)) +    # 核心：rainbow 4色
  geom_text(aes(label = group), position = position_stack(vjust = 0.5), size = 6) +
  theme_void() +  # 清空背景坐标轴
  labs(
    title = "饼图：Rainbow 填色 + 白色边框",
    fill = "分组"
  ) +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    legend.position = "right"
  )


## 改变排布
df <- tibble(
  group = letters[1:4],
  value = 1:4
)

ggplot(df, aes(x = "", y = value, fill = group)) +
  geom_col(color = "white", linewidth = 1) +
  coord_polar(theta = "y", direction = -1, start = 0) +
  scale_fill_manual(values = rainbow(4)) +
  geom_text(aes(label = group), 
            position = position_stack(vjust = 0.5), 
            size = 6) +
  
  theme_void() +
  labs(title = "顺时针彩虹饼图", fill = "分组") +
  theme(plot.title = element_text(hjust = 0.5, size=14, face="bold"))


# 箱线图
## 基础箱线图
set.seed(123)  # 固定随机数，结果可复现
r <- rnorm(50, 0, 1)
b <- c(r, 5, 6, -5, -6)

df <- tibble(
  value = b
)

ggplot(df, aes(x = "", y = value)) +
  geom_boxplot(fill = "lightblue", color = "black", outlier.color = "red", outlier.shape = 16) +
  labs(
    title = "数据 b 的箱线图",
    x = NULL,
    y = "数值"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.text.x = element_blank(),  # 隐藏x轴文字
    axis.ticks.x = element_blank()  # 隐藏x轴刻度
  )


## 按照不同类别画箱线图
set.seed(123)          # 固定随机数，结果可复现
r2 <- c(rnorm(50, 0, 1), rnorm(50, 10, 1))
r3 <- c(rep(c('class1', 'class2'), times = c(50, 50)))
rand_data <- data.frame(r2, r3)

ggplot(rand_data, aes(x = r3, y = r2, fill = r3)) +
  geom_boxplot(
    color = "black",        # 箱线边框黑色
    outlier.color = "red",  # 异常值红色
    outlier.shape = 16      # 异常值圆点
  ) +
  scale_fill_manual(values = c("lightblue", "lightgreen")) +
  labs(
    title = "class1 vs class2 箱线图对比",
    x = "类别",
    y = "数值 r2",
    fill = "分组"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    legend.position = "none"  # 不需要重复图例
  )
