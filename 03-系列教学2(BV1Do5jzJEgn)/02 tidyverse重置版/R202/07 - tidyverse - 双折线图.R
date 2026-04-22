# 导入数据
library(readxl)
stock <- read_excel('./data/stock.xlsx')

library(tidyverse)

# 绘制到同一张图幅上
ggplot(stock, aes(x = date)) +
  # 第一条折线：上证收盘价 → 蓝色 实线
  geom_line(
    aes(y = SH_closing_price, color = "上证收盘价", linetype = "上证收盘价"),
    linewidth = 1
  ) +
  
  # 第二条折线：投资者信心指数 → 红色 虚线
  geom_line(
    aes(y = investor_confidence_index, color = "投资者信心指数", linetype = "投资者信心指数"),
    linewidth = 1
  ) +
  
  # 手动指定颜色
  scale_color_manual(
    values = c(
      "上证收盘价" = "#2E86AB",      # 蓝色
      "投资者信心指数" = "#E63946"  # 红色
    )
  ) +
  
  # 手动指定线型（实线 vs 虚线）
  scale_linetype_manual(
    values = c(
      "上证收盘价" = "solid",       # 实线
      "投资者信心指数" = "dashed"   # 虚线
    )
  ) +
  
  # 坐标轴与标题
  labs(
    title = "上证收盘价与投资者信心指数走势对比",
    x = "日期",
    y = "数值",
    color = "指标",
    linetype = "指标"
  ) +
  
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    legend.position = "bottom"
  )

# 绘制到两张子图上
library(patchwork) # 分图神器，需要先安装（install.packages("patchwork")）

# 子图1：上证收盘价（蓝色实线）
p1 <- ggplot(stock, aes(x = date, y = SH_closing_price)) +
  geom_line(color = "#2E86AB", linewidth = 1, linetype = "solid") +
  labs(
    title = "上证收盘价",
    x = "日期",
    y = "收盘价"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 12, face = "bold"))

# 子图2：投资者信心指数（红色虚线）
p2 <- ggplot(stock, aes(x = date, y = investor_confidence_index)) +
  geom_line(color = "#E63946", linewidth = 1, linetype = "dashed") +
  labs(
    title = "投资者信心指数",
    x = "日期",
    y = "信心指数"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 12, face = "bold"))

# 左右排布拼接（核心代码）
p1 + p2 +
  plot_annotation(
    title = "上证收盘价 & 投资者信心指数走势对比",
    theme = theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"))
  )


# 绘制到双坐标图上
ggplot(stock, aes(x = date)) +
  
  # 第一条线：上证收盘价 → 左Y轴
  geom_line(
    aes(y = SH_closing_price),
    color = "#2E86AB", linewidth = 1, linetype = "solid"
  ) +
  
  # 第二条线：投资者信心指数 → 右Y轴（必须做数值缩放）
  geom_line(
    aes(y = investor_confidence_index * 60),  # 放大到和收盘价同一视觉区间
    color = "#E63946", linewidth = 1, linetype = "dashed"
  ) +
  
  # 左Y轴（收盘价）
  scale_y_continuous(
    name = "上证收盘价",
    limits = c(2000, 5000),  # 你之前要的范围
    
    # 右Y轴设置（信心指数）
    sec.axis = sec_axis(
      ~ . / 60,             # 对应上面的 *60，反向还原
      name = "投资者信心指数"
    )
  ) +
  
  # 标题
  labs(
    title = "上证收盘价与投资者信心指数（双Y轴）",
    x = "日期"
  ) +
  
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.title.y.left = element_text(color = "#2E86AB"),
    axis.title.y.right = element_text(color = "#E63946")
  )
