# install.packages("writexl")
library(writexl)

# 固定随机数，结果可复现
set.seed(123)

# 生成 577 条天猫电视模拟数据
tianmao_2 <- data.frame(
  shop_id = sample(1001:1050, 577, replace = TRUE),
  shop_name = paste0("店铺", sample(1:50, 577, replace = TRUE)),
  
  # 原价（正浮点数，比现价高，更合理）
  original_price = round(runif(577, min = 699.9, max = 5999.9), 2),
  
  # 现价（正浮点数）
  current_price = round(runif(577, min = 599.9, max = 4999.9), 2),
  
  # 月销量（正整数）
  month_sales_count = sample(1:5000, 577, replace = TRUE),
  
  # 库存
  stock = sample(0:500, 577, replace = TRUE)
)


# 导出为 xlsx
write_xlsx(tianmao_2, "tianmaoTV.xlsx")

# 查看前6行 + 数据规模
head(tianmao_2)
cat("总样本数：", nrow(tianmao_2), "\n")