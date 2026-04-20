library(writexl)

set.seed(123)

# 生成时间序列
time_seq <- seq.Date(as.Date("2020-01-01"), 
                     as.Date("2024-12-01"), 
                     by = "month")
n <- length(time_seq)

# 生成数据
stock <- data.frame(
  time = time_seq,
  investor_confidence_index = round(runif(n, 40, 80), 2),
  SH_closing_price = round(runif(n, 22000, 38000), 2),
  SZ_closing_price = round(runif(n, 19000, 42000), 2),
  HSCI_closing_price = round(runif(n, 18000, 32000), 2)
)

# 导出 Excel
write_xlsx(stock, "stock.xlsx")

# 查看
head(stock)