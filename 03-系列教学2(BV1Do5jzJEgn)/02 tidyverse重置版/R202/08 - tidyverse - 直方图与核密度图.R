# 读取数据
library(readxl)
returndaily <- read_excel('./data/returndaily.xlsx')

# 绘制直方图
## 绘制直方图
ggplot(returndaily, aes(x = SH_return_daily)) +
  # 直方图 + 透明度
  geom_histogram(
    bins = 40,                # 柱子数量（可调）
    fill = "#4682B4",         # 填充颜色
    color = "white",          # 边框白色（更清晰）
    alpha = 0.8
  ) +
  # 标签
  labs(
    x = "上证指数日收益率",
    y = "频数",
    title = "上证指数日收益率分布直方图"
  ) +
  # 主题美化
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.title = element_text(size = 12)
  )


## 修改直方图单元格数量 - 略（修改上述的"bins=40"即可）
## 获取直方图统计信息 - 略（ggplot不能生成统计信息，需要用Base R的hist统计！）


# 绘制核密度图
ggplot(returndaily, aes(x = SH_return_daily)) +
  # 核密度曲线
  geom_density(
    color = "#ff5733",
    linewidth = 1.5
  ) +
  labs(
    x = "上证指数日收益率",
    y = "密度",
    title = "收益率分布：直方图 + 核密度曲线"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 14))



# 将直方图和核密度图画在一起
ggplot(returndaily, aes(x = SH_return_daily)) +
  # 直方图
  geom_histogram(
    aes(y = ..density..),  # 关键：让直方图按密度缩放
    bins = 40,
    fill = "lightgray",
    color = "white",
    alpha = 0.7
  ) +
  # 核密度曲线
  geom_density(
    color = "#ff5733",
    linewidth = 1.5
  ) +
  labs(
    x = "上证指数日收益率",
    y = "密度",
    title = "收益率分布：直方图 + 核密度曲线"
  ) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 14))


# 生成正态分布并对比
df_normal <- tibble(
  x = rnorm(n = 10000, mean = 0, sd = 1),
  type = "标准正态分布 N(0,1)"
)

df_return <- returndaily %>%
  select(x = SH_return_daily) %>%
  mutate(type = "上证指数日收益率")

df_combined <- bind_rows(df_normal, df_return)

# 2. 绘制双图（关键：scales = "free"）
ggplot(df_combined, aes(x = x)) +
  geom_histogram(
    aes(y = ..density..),
    bins = 50,
    fill = "#4682B4",
    color = "white",
    alpha = 0.7
  ) +
  geom_density(
    color = "#FF4500",
    linewidth = 1.2
  ) +
  # 关键改动：scales = "free"，x、y轴都独立适配
  facet_wrap(~type, nrow = 1, scales = "free") +
  labs(
    x = "数值",
    y = "密度",
    title = "分布对比：标准正态分布 vs 上证指数日收益率"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    strip.text = element_text(size = 12, face = "bold")
  )


