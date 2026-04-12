library(writexl)

# 固定随机数，保证数据可复现
set.seed(666)

# 时间和 stock.xlsx 完全一致（2020-01-01 ~ 2024-12-01）
time_seq <- seq.Date(as.Date("2020-01-01"),
                     as.Date("2024-12-01"),
                     by = "month")
n <- length(time_seq)

# 生成 上证指数日收益率（模拟真实收益率：小波动、接近0）
SH_return_daily <- round(rnorm(n, mean = 0, sd = 0.025), 4)
SZ_return_daily <- round(rnorm(n, mean = 0, sd = 0.025), 4)

# 构造数据框（全英文列名）
returndaily <- data.frame(
  time = time_seq,                # 时间（和stock完全对应）
  SH_return_daily = SH_return_daily,  # 上证指数日收益率
  SZ_return_daily = SZ_return_daily # 深证指数日收益率
)

# 导出 Excel
write_xlsx(returndaily, "returndaily.xlsx")

# 查看前6行
head(returndaily)
cat("returndaily.xlsx 生成成功！共", nrow(returndaily), "条数据\n")