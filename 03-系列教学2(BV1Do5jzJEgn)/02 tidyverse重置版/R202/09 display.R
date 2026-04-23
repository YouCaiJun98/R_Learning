library(tidyverse)
library(scales)

# 查看tidyverse内置颜色（默认离散调色板 + scales/ggplot2 自带调色板）


# 使用内置颜色做可视化
## R-rainbow + tidyverse做颜色可视化
color_data <- tibble(
  category = factor(1:10),
  height = 1
)

# 绘图：柔和透明彩虹色
ggplot(color_data, aes(x = category, y = height)) +
  geom_col(
    aes(fill = category),
    color = "white",      # 白色边框分隔
    linewidth = 0.5,
    alpha = 0.6           # ✅ 核心：透明度（0~1，越小越淡）
  ) +
  scale_fill_manual(values = rainbow(10)) +  # 彩虹色
  guides(fill = "none") +
  labs(
    title = "R 彩虹调色板（柔和透明版）",
    x = "颜色编号",
    y = ""
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size=14, face="bold"),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  )

## R-heatmap + tidyverse做颜色可视化
color_data <- tibble(
  category = factor(1:10),
  height = 1
)

# 2. 绘制 heat.colors 热力色图（透明柔和）
ggplot(color_data, aes(x = category, y = height)) +
  geom_col(
    aes(fill = category),
    color = "white",      # 白色边框，分隔更清晰
    linewidth = 0.5,
    alpha = 0.7          # 透明度，让颜色更柔和
  ) +
  # 核心：使用 R 内置热力调色板 heat.colors(10)
  scale_fill_manual(values = heat.colors(10)) +
  guides(fill = "none") +  # 去掉图例
  labs(
    title = "R 内置 heat.colors 热力调色板（10色）",
    x = "颜色编号",
    y = ""
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.text.y = element_blank(),  # 隐藏y轴文字
    axis.ticks.y = element_blank()  # 隐藏y轴刻度
  )

## R-cm + tidyverse做颜色可视化
color_data <- tibble(
  category = factor(1:10),
  height = 1
)

# 绘图：cm.colors 调色板（青色 → 品红色）
ggplot(color_data, aes(x = category, y = height)) +
  geom_col(
    aes(fill = category),
    color = "white",
    linewidth = 0.5,
    alpha = 0.7  # 保持柔和透明
  ) +
  # 核心：换成 cm.colors(10)
  scale_fill_manual(values = cm.colors(10)) +
  guides(fill = "none") +
  labs(
    title = "R 内置 cm.colors 调色板（10色）",
    x = "颜色编号",
    y = ""
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  )


# 扩展颜色 + mtcars示例绘制
## 颜色拓展

## mtcars示例绘制



# 查看内置配色方案


# tidyverse + 其他配色方案绘图示例


