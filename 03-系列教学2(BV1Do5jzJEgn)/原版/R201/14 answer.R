# 1、导入数据集tianmaoTV.xlsx，把生成的数据框命名成tianmao
library(readxl)
tianmao <- read_excel("./data/tianmaoTV.xlsx", skip = 1)

# 2、计算每个品牌的总销量，把销量前十的结果保存到brand_amount数据框里
sales_brands <- aggregate(tianmao['month_sales_count'],
                          by=list(brands=tianmao$brand), sum)
brand_amount <- sales_brands[order(
  sales_brands$month_sales_count, decreasing = T), ][1:10,]

# 3、画出销量前十的品牌的总销量柱状图，并把小米、海尔、海信这三个品牌标识出来。
brand_amount <- brand_amount[order(brand_amount$month_sales_count), ]
plot_rst <- barplot(
  brand_amount$month_sales_count,
  names.arg = brand_amount$brands,
  horiz = T,
  las = T,
  cex.names = 0.6,
  border = NA,
  col = 'grey',
  xlim = c(0, 100000),
  axes = F
)

options(scipen = 999) # 禁用科学计数法
axis(
  side = 1,
  at = seq(0, 100000, 20000),
  labels = seq(0, 100000, 20000),
  tick = TRUE,
  cex.axis = 0.7
)

## 高亮三个品牌
selected_brands <- c("Xiaomi/小米", "Hisense/海信", "Haier/海尔")
brand_amount$domestic <- ifelse(brand_amount$brands %in% selected_brands, 1, 0)

brand_amount_vector <- brand_amount$month_sales_count*brand_amount$domestic
barplot(
  brand_amount_vector,
  names.arg = F,
  horiz = T,
  border = NA,
  col = 'orange1',
  axes = F,
  add = T
)