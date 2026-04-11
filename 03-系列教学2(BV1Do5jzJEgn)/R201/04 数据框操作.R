# 导入数据集
library(readxl)
tianmao <- read_excel('./data/tianmaoTV.xlsx')

# 数据框操作 - 列运算 & 增加新列
tianmao['total_sales'] <- tianmao$current_price * tianmao$month_sales_count
tianmao$discount <- tianmao$current_price / tianmao$original_price
tianmao['price_tag'] <- ifelse(tianmao$current_price < 1000, 'low price',
                               ifelse(tianmao$current_price <= 2000, 'fair price',
                               'high price'))
tianmao[c('price_tag', 'current_price')]

# ifelse函数演示
a <- 1:10
ifelse(a%%2==0, 'even', 'odd')

# 数据框操作 - 重命名
names(tianmao)
names(tianmao)[1] <- 'new_name'
names(tianmao) %in% "discount"
"discount" %in% names(tianmao)
# 数据框操作 - 复杂重命名逻辑
names(tianmao)[names(tianmao) %in% "discount"] = 'zhekou'

# 提取子集 - 列
new_data <- tianmao[, -c(1:3)]
col1 <- c('new_name', 'shop_name', 'original_price')
new_data2 <- tianmao[, -col1] # 这个是错误的！
col1_idx <- names(tianmao) %in% col1
new_data2 <- tianmao[, !col1_idx]

# 提取子集 - 行
tianmao[1, ]
tianmao$shop_name == '店铺36'
shop_36 <- tianmao[tianmao$shop_name == '店铺36', ]

# 提取子集 - 函数法
shop_15 <- subset(tianmao, shop_name=="店铺15", c("current_price", "month_sales_count"))

