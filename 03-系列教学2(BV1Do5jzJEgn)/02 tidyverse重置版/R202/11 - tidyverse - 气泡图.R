library(tidyverse)

# 基础气泡图
## 基础气泡图绘制
ggplot(mtcars, aes(x = disp, y = wt)) +
  # 核心：geom_point 绘制气泡，size 映射 mpg
  geom_point(
    aes(size = mpg),       # 气泡大小由 mpg 决定
    alpha = 0.6,           # 透明一点更好看
    color = "steelblue",   # 气泡颜色
    fill = "steelblue"
  ) +
  # 调整气泡大小范围（避免太小/太大）
  scale_size_continuous(range = c(3, 15)) +
  # 标签
  labs(
    title = "汽车数据气泡图",
    x = "排量 (disp)",
    y = "车重 (wt)",
    size = "油耗 (mpg)"    # 图例名称
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold")
  )

## 改变气泡形状
ggplot(mtcars, aes(x = disp, y = wt)) +
  geom_point(
    aes(size = mpg),
    shape = 22,       # ✅ 这里改形状！数字对应不同图形
    alpha = 0.7,
    fill = "steelblue",  # 填充色
    color = "black",     # 边框色
    stroke = 1           # 边框粗细
  ) +
  scale_size_continuous(range = c(3, 15)) +
  labs(
    title = "自定义形状的气泡图",
    x = "排量 (disp)",
    y = "重量 (wt)",
    size = "油耗 (mpg)"
  ) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))

## 缩放气泡大小
ggplot(mtcars, aes(x = disp, y = wt)) +
  geom_point(
    aes(size = mpg),
    shape = 16,        # 保持圆形
    alpha = 0.7,       # 透明柔和
    color = "steelblue"
  ) +
  # ✅ 核心：放大气泡！range 数值调大即可
  scale_size_continuous(range = c(10, 30)) +  
  labs(
    title = "放大版圆形气泡图",
    x = "排量 (disp)",
    y = "车重 (wt)",
    size = "油耗 (mpg)"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold")
  )

## 改变气泡颜色
ggplot(mtcars, aes(x = disp, y = wt)) +
  geom_point(
    aes(size = mpg),
    shape = 21,        # 必须用 21：支持 填充色 + 边缘色
    fill = "red",      # ✅ 填充色 = 红色
    color = "green",   # ✅ 边缘色 = 绿色
    stroke = 2,        # 边缘粗细（让绿色更明显）
    alpha = 0.8        # 透明度
  ) +
  scale_size_continuous(range = c(5, 20)) +  # 气泡大小
  labs(
    title = "气泡图：红色填充 + 绿色边缘",
    x = "排量 (disp)",
    y = "车重 (wt)",
    size = "油耗 (mpg)"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold")
  )

## 用调色板绘制气泡图
ggplot(mtcars, aes(x = disp, y = wt)) +
  geom_point(
    aes(size = mpg, fill = mpg),   
    shape = 21,        # 圆形可填充
    color = NULL,      # 彻底去掉边框，避免NA导致的渲染问题
    stroke = 0,        # 边框粗细设为0，和去掉边框效果一致
    alpha = 0.9        
  ) +
  # 核心：修正颜色方向 → mpg越大越红
  scale_fill_gradientn(
    colors = rev(heat.colors(100))  # rev() 反转色板
  ) +
  scale_size_continuous(range = c(5, 20)) +
  labs(
    title = "气泡图：mpg越大颜色越红",
    x = "排量 (disp)",
    y = "车重 (wt)",
    fill = "MPG",
    size = "MPG"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold")
  )

## 在气泡图中添加辅助线
mean_disp <- mean(mtcars$disp)
mean_wt   <- mean(mtcars$wt)

ggplot(mtcars, aes(x = disp, y = wt)) +
  # 辅助线
  geom_vline(xintercept = mean_disp, color = "gray50", linetype = "dashed", linewidth = 0.3) +
  geom_hline(yintercept = mean_wt,   color = "gray50", linetype = "dashed", linewidth = 0.3) +
  
  # 气泡：支持fill的形状 + 无边框 + 热力色
  geom_point(
    aes(size = mpg, fill = mpg),
    shape = 21,        # 支持fill
    color = NULL,      # 不设置边框色
    stroke = 0,        # 边框宽度设为0（相当于无边框）
    alpha = 0.9
  ) +
  
  # 热力色板：mpg越大越红
  scale_fill_gradientn(colors = rev(heat.colors(100))) +
  
  # 气泡大小
  scale_size_continuous(range = c(5, 20)) +
  
  labs(
    title = "气泡图：mpg越大越红（含均值辅助线）",
    x = "排量 (disp)",
    y = "车重 (wt)",
    fill = "MPG",
    size = "MPG"
  ) +
  
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))

## 用均值划分区域，不同区域的气泡图对应不同颜色

library(RColorBrewer)


mean_disp <- mean(mtcars$disp)
mean_wt   <- mean(mtcars$wt)


mtcars <- mtcars %>%
  mutate(
    quadrant = case_when(
      disp >= mean_disp & wt >= mean_wt ~ "Q1",
      disp <  mean_disp & wt >= mean_wt ~ "Q2",
      disp <  mean_disp & wt <  mean_wt ~ "Q3",
      disp >= mean_disp & wt <  mean_wt ~ "Q4"
    )
  )


ggplot(mtcars, aes(x = disp, y = wt)) +
  # 灰色细虚线辅助线
  geom_vline(xintercept = mean_disp, color = "gray50", linetype = "dashed", linewidth = 0.3) +
  geom_hline(yintercept = mean_wt,   color = "gray50", linetype = "dashed", linewidth = 0.3) +
  
  # 气泡：无边框 + 按象限上色 + 大小由mpg控制
  geom_point(
    aes(size = mpg, fill = quadrant),
    shape = 21,          
    color = "transparent",  # 边框彻底透明（看不见）
    stroke = 1,
    alpha = 0.9
  ) +
  
  # 使用 PiYG 配色给4个区域上色
  scale_fill_manual(values = brewer.pal(5, "PiYG")[2:5]) +
  
  # 气泡大小范围
  scale_size_continuous(range = c(5, 20)) +
  
  # 标签
  labs(
    title = "按均值分4区域气泡图",
    x = "排量 (disp)",
    y = "车重 (wt)",
    fill = "象限",
    size = "MPG"
  ) +
  
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))
