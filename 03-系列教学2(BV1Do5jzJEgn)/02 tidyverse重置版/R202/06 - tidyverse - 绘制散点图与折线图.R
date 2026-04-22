# 导入数据
library(readxl)
stock <- read_excel('./data/stock.xlsx')

library(tidyverse)

# 绘制折线图
## SH收盘价格关于日期的折线
ggplot(stock, aes(x = date, y = SH_closing_price)) +
  geom_line(linewidth = 1, color = "#2E86AB") +
  # 替换 ylim(2000, 5000) 为 coord_cartesian
  coord_cartesian(ylim = c(2000, 5000)) + 
  labs(
    title = "上证综指收盘价时间序列",
    x = "日期",
    y = "收盘价"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.text = element_text(size = 11)
  )


## 在折线图中添加竖线（日期分界线）
ggplot(stock, aes(x = date, y = SH_closing_price)) +
  geom_line(linewidth = 1, color = "#2E86AB") +
  geom_vline(xintercept = as.Date("2016-10-03"),
             color = "red", linetype = "dashed") + 
  # 替换 ylim(2000, 5000) 为 coord_cartesian
  coord_cartesian(ylim = c(2000, 5000)) + 
  labs(
    title = "上证综指收盘价时间序列",
    x = "日期",
    y = "收盘价"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.text = element_text(size = 11)
  )


## 在一张图中绘制多条曲线
ggplot(stock, aes(x = date, y = SH_closing_price)) +
  geom_line(linewidth = 1, color = "#2E86AB") +
  geom_line(
    aes(y = SZ_closing_price, color = "深证成指"),
    linewidth = 1, linetype = "dashed"
  ) +
  geom_vline(xintercept = as.Date("2016-10-03"),
             color = "red", linetype = "dashed") + 
  # 替换 ylim(2000, 5000) 为 coord_cartesian
  coord_cartesian(ylim = c(2000, 5000)) + 
  labs(
    title = "上证综指收盘价时间序列",
    x = "日期",
    y = "收盘价"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.text = element_text(size = 11)
  )


# 绘制散点图
## 根据不同的分类标签，用不同的颜色与类型描述
stock %>%
  # 第一步：根据上证收盘价分类（<3000 一类，≥3000 一类）
  mutate(
    price_group = case_when(
      SH_closing_price < 3000 ~ "低于3000点",
      SH_closing_price >= 3000 ~ "高于等于3000点"
    )
  ) %>%
  
  # 开始画散点图
  ggplot(aes(x = SH_closing_price, 
             y = investor_confidence_index,
             shape = price_group,  # 分类决定点型
             color = price_group)) +  # 分类决定颜色
  
  # 散点大小调大，更清晰
  geom_point(size = 3) +
  
  # 手动设置：不同颜色 + 不同点型
  scale_color_manual(values = c("低于3000点" = "#457B9D", 
                                "高于等于3000点" = "#E63946")) +
  scale_shape_manual(values = c("低于3000点" = 16,  # 实心圆
                                "高于等于3000点" = 17)) +  # 实心三角
  
  # 标题与坐标轴
  labs(
    title = "上证收盘价 vs 投资者信心指数",
    x = "上证综指收盘价",
    y = "投资者信心指数",
    shape = "价格分类",
    color = "价格分类"
  ) +
  
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    legend.position = "bottom"
  )


