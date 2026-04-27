# 导入数据
library(readxl)
tianmao <- read_excel("./data/tianmaoTV.xlsx", skip = 1)

# 计算品牌平均价格
tianmao <- read_excel('./data/tianmaoTV.xlsx', skip=1)

brand_price_avg <- tianmao %>%
  # 按品牌分组
  group_by(brand) %>%
  # 计算均价，同时去掉NA
  summarise(
    avg_price = mean(current_price, na.rm = TRUE)
  ) %>%
  # 按均价降序排列
  arrange(desc(avg_price)) %>%
  # 只保留前10个品牌
  slice_head(n = 10)

print(brand_price_avg)

# 根据品牌做分类
brand_price_avg <- brand_price_avg %>%
  mutate(
    label = if_else(
      brand %in% c("AOC", "Hisense/海信", "Skyworth/创维", "Haier/海尔", "乐视TV"),
      1,  # 符合条件 → 标签1
      0   # 不符合 → 标签0
    )
  )

# 绘制柱状图
ggplot(brand_price_avg, aes(x = avg_price, y = reorder(brand, avg_price))) +
  geom_col(fill = "gray") +   # 柱子设为灰色
  theme_minimal() +
  labs(
    x = NULL,                 # 隐去x轴标题
    y = NULL,                 # 去掉y轴标题
    title = "品牌均价TOP10"
  ) +
  theme(
    axis.text.x = element_blank(),   # 隐藏x轴刻度文字
    axis.ticks.x = element_blank(),  # 隐藏x轴刻度线
    plot.title = element_text(hjust = 0.5, size = 14)
  )

# 高亮部分柱子
ggplot(brand_price_avg, 
       aes(x = avg_price, 
           y = reorder(brand, avg_price),  # 按均价排序品牌
           fill = factor(label))) +       # 用label控制颜色
  
  # 画柱子
  geom_col(width = 0.7) +
  
  # 颜色设置：0=灰色，1=橙色
  scale_fill_manual(values = c("0" = "gray", "1" = "orange")) +
  
  # X轴刻度：0、2、4、6、8、10 千元
  scale_x_continuous(
    breaks = c(0, 2000, 4000, 6000, 8000, 10000),
    labels = c("0", "2", "4", "6", "8", "10"),
    limits = c(0, 10001)  # 关键：把x轴上限设为11000，留出空间显示10的刻度
  ) +
  
  # 标签与标题
  labs(
    x = "价格（千元）",
    y = NULL,
    title = "电视品牌均价TOP10"
  ) +
  
  # 主题样式
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 15),
    legend.position = "none"  # 隐藏不需要的图例
  )


# 加上颜色前景框
ggplot(brand_price_avg, 
       aes(x = avg_price, 
           y = reorder(brand, avg_price),
           fill = factor(label))) +
  # 先画背景色块（geom_rect要放在geom_col前面）
  geom_rect(
    aes(xmin = 0, xmax = 5000, ymin = -Inf, ymax = Inf),
    fill = "#cce7ff", alpha = 0.4, inherit.aes = FALSE
  ) +
  geom_rect(
    aes(xmin = 5000, xmax = 10000, ymin = -Inf, ymax = Inf),
    fill = "#99ccff", alpha = 0.4, inherit.aes = FALSE
  ) +
  # 再画条形图
  geom_col(width = 0.7) +
  # 颜色设置
  scale_fill_manual(values = c("0" = "gray", "1" = "orange")) +
  # X轴刻度与范围
  scale_x_continuous(
    breaks = c(0, 2000, 4000, 6000, 8000, 10000),
    labels = c("0", "2", "4", "6", "8", "10"),
    limits = c(0, 10001)
  ) +
  # 标签与标题
  labs(
    x = "价格（千元）",
    y = NULL,
    title = "电视品牌均价TOP10"
  ) +
  # 主题样式
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 15),
    legend.position = "none"
  )

