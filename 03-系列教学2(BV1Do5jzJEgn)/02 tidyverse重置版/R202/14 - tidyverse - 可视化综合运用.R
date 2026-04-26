# 导入数据
library(readxl)
tianmao <- read_excel("./data/tianmaoTV.xlsx", skip = 1)

# 计算品牌平均价格
brand_avg_price <- tianmao %>%
  # 按品牌分组
  group_by(brand) %>%
  # 计算均价（自动忽略NA值）
  summarise(
    avg_price = mean(current_price, na.rm = TRUE)
  ) %>%
  # 按均价降序排列
  arrange(desc(avg_price)) %>%
  # 取前10个品牌
  slice_head(n = 10) %>%
  # 重置行号（可选，更干净）
  ungroup()

# 根据品牌做分类
brand_avg_price <- brand_avg_price %>%
  mutate(
    # 新增一列 label：符合品牌 = 1，否则 = 0
    label = if_else(
      brand %in% c("AOC", "Hisense/海信", "Skyworth/创维", "Haier/海尔", "乐视TV"),
      1,  # 满足条件
      0   # 不满足条件
    )
  )

# 绘制柱状图
ggplot(brand_avg_price, 
       aes(x = avg_price, y = reorder(brand, avg_price))) +
  geom_col(fill = "gray60") +
  labs(y = "品牌") +  # 保留Y轴标题，去掉X轴标题
  theme_minimal() +
  theme(
    # 彻底隐藏X轴所有元素
    axis.title.x = element_blank(),   # 去掉X轴标题
    axis.text.x = element_blank(),    # 去掉X轴刻度数字
    axis.ticks.x = element_blank(),   # 去掉X轴刻度线
    # 隐藏所有网格线（避免残留）
    panel.grid = element_blank(),
    # 可选：美化Y轴
    axis.text.y = element_text(size = 11),
    axis.title.y = element_text(size = 12, face = "bold")
  )

# 高亮部分柱子
ggplot(brand_avg_price, 
       aes(x = avg_price / 1000,    # 转成千元单位，方便刻度设置
           y = reorder(brand, avg_price))) +
  geom_col(aes(fill = factor(label)),  # 按label分组设置颜色
           width = 0.7) +
  # 颜色映射：label=1为橙色，0为灰色
  scale_fill_manual(values = c("0" = "gray60", "1" = "orange"),
                    guide = "none") +  # 去掉图例
  # 设置X轴刻度：0、2、4、6、8、10（千元）
  scale_x_continuous(breaks = c(0, 2, 4, 6, 8, 10),
                     labels = c("0", "2", "4", "6", "8", "10"),
                     limits = c(0, 10)) +
  labs(
    x = "价格（千元）",
    y = "品牌"
  ) +
  theme_minimal() +
  theme(
    axis.title.x = element_text(size = 11),
    axis.title.y = element_text(size = 12, face = "bold"),
    panel.grid.major.y = element_blank(),  # 去掉横向网格线
    panel.grid.minor = element_blank()
  )


# 加上颜色前景框
ggplot(brand_avg_price, 
       aes(x = avg_price / 1000,    # 价格转千元
           y = reorder(brand, avg_price))) +
  # 1. 价格区间透明蓝框（放在最底层，作为背景）
  annotate("rect", 
           xmin = 0, xmax = 5,    # 0-5千元（<5000）
           ymin = -Inf, ymax = Inf, 
           fill = "#e0f3ff", alpha = 0.5) +  # 浅蓝透明
  
  annotate("rect", 
           xmin = 5, xmax = 10,   # 5-10千元（>5000）
           ymin = -Inf, ymax = Inf, 
           fill = "#b3e0ff", alpha = 0.5) +  # 稍深一点的蓝透明
  
  # 2. 条形图（放在框的上层）
  geom_col(aes(fill = factor(label)), 
           width = 0.7) +
  
  # 3. 颜色映射：label=1为橙色，0为灰色
  scale_fill_manual(values = c("0" = "gray60", "1" = "orange"),
                    guide = "none") +  # 去掉图例
  
  # 4. X轴千元刻度
  scale_x_continuous(breaks = c(0, 2, 4, 6, 8, 10),
                     labels = c("0", "2", "4", "6", "8", "10"),
                     limits = c(0, 10)) +
  
  # 5. 标签与主题
  labs(
    x = "价格（千元）",
    y = "品牌"
  ) +
  theme_minimal() +
  theme(
    axis.title.x = element_text(size = 11),
    axis.title.y = element_text(size = 12, face = "bold"),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank()
  )

