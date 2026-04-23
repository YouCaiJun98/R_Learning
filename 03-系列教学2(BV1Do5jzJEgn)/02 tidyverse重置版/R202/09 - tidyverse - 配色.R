library(tidyverse)
library(scales)

# 查看tidyverse内置颜色（默认离散调色板 + scales/ggplot2 自带调色板）
## 默认离散调色板
hue_pal()(16)
show_col(hue_pal()(64))



# 使用内置颜色做可视化
## R-rainbow + tidyverse做颜色可视化
df <- tibble(
  category = paste0("柱_", 1:10),  # 10个类别
  value = 10                       # 高度全部一样
)

ggplot(df, aes(x = category, y = value, fill = category)) +
  geom_col(color = "black", linewidth = 0.5) +  # 黑边更清晰
  scale_fill_manual(values = rainbow(10, alpha = 0.6)) +     # 彩虹10色
  theme_minimal() +
  labs(title = "rainbow 调色板 10 色等高柱状图",
       x = "类别", y = "") +
  theme(legend.position = "none",               # 隐藏图例
        plot.title = element_text(hjust = 0.5)) # 标题居中


## R-heatmap + tidyverse做颜色可视化
df <- tibble(
  category = paste0("柱_", 1:10),
  value = 10  # 高度全部一样
)


ggplot(df, aes(x = category, y = value, fill = category)) +
  geom_col(color = "black", linewidth = 0.5) +
  # 核心：换成 heatmap 调色板
  scale_fill_manual(values = heat.colors(10)) +
  theme_minimal() +
  labs(title = "heatmap 调色板 10 色等高柱状图",
       x = "类别", y = "") +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5))

## R-cm + tidyverse做颜色可视化
df <- tibble(
  category = paste0("柱_", 1:10),
  value = 10  # 高度完全一样
)

ggplot(df, aes(x = category, y = value, fill = category)) +
  geom_col(color = "black", linewidth = 0.5) +
  # 核心：换成 cm 调色板
  scale_fill_manual(values = cm.colors(10)) +
  theme_minimal() +
  labs(title = "cm.colors 调色板 10 色等高柱状图",
       x = "类别", y = "") +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5))


# 扩展颜色 + mtcars示例绘制
## 颜色拓展
color_start <- "yellow"# 1. 定义你想要的【两个起始颜色】
color_end   <- "red" 

ramp <- colour_ramp(c(color_start, color_end)) # 2. 创建插值函数（关键！）

my_colors <- ramp(seq(0, 1, length.out = 100)) # 3. 生成 10 个插值颜色（你想要多少个就写多少）

show_col(my_colors) # 4. 查看颜色


## mtcars示例绘制
ggplot(mtcars, aes(x = wt, y = disp, color = wt)) + # 关键：加上 color = wt
  geom_point(size = 4, alpha = 0.8, shape = 19) +
  scale_color_gradientn(colors = my_colors) + # 现在能生效了
  theme_minimal() +
  labs(
    title = "车重(wt) vs 排量(disp) 散点图",
    subtitle = "颜色：黄色 → 红色 自定义插值渐变",
    x = "车重 (wt)",
    y = "排量 (disp)",
    color = "车重 wt"
  ) +
  theme(plot.title = element_text(hjust = 0.5))


# 查看内置配色方案
## Viridis系调色板
show_col(viridis_pal()(16))          # viridis
show_col(viridis_pal(option="A")(10))# magma
show_col(viridis_pal(option="B")(10))# inferno
show_col(viridis_pal(option="C")(10))# plasma

## ColorBrewer系调色板
### 定性调色板（Set1、Paired 等）
show_col(brewer_pal(type="qual", palette="Set1")(9))
### 顺序调色板（Blues、Greens）
show_col(brewer_pal(type="seq", palette="Blues")(9))
### 分歧调色板（RdBu、Spectral）
show_col(brewer_pal(type="div", palette="RdBu")(9))

## 灰色系调色板
show_col(grey_pal()(8))


# tidyverse + 其他配色方案绘图示例
library(colorspace)  # 必须加载

# 1. 创建 8 根等高柱子
df <- tibble(
  category = paste0("柱_", 1:8),
  value = 10  # 高度一致
)

# 2. 生成 warm 调色板 8 个颜色（你要的！）
my_colors <- qualitative_hcl(n = 8, palette = "warm")

# 3. 画图
ggplot(df, aes(x = category, y = value, fill = category)) +
  geom_col(color = "black", linewidth = 0.5) +
  scale_fill_manual(values = my_colors) +  # 用 warm 色
  theme_minimal() +
  labs(title = "colorspace :: warm 调色板（8色）",
       x = "类别", y = "") +
  theme(legend.position = "none",
        plot.title = element_text(hjust = 0.5))
