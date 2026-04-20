# 导入数据
library(readxl)
tianmao <- read_excel("./data/tianmaoTV.xlsx", skip = 1)

# 计算品牌平均价格
price_brands <- aggregate(tianmao['current_price'],
                          by=list(brands=tianmao$brand), mean)
price_brands <- price_brands[order(
  price_brands$current_price, decreasing = T), ][1:10,]

# 根据品牌做分类
price_brands$brands
domestic <- c("AOC", "Hisense/海信", "Skyworth/创维", "Haier/海尔", "乐视TV")
price_brands$domestic <- ifelse(price_brands$brands %in% domestic, 1, 0)

# 绘制柱状图
par(mar=c(5, 5, 2, 2)) # 调整左边距
price_brands <- price_brands[order(price_brands$current_price), ]
plot_rst <- barplot(
  price_brands$current_price,
  names.arg = price_brands$brands,
  horiz = T,
  las = T,
  cex.names = 0.6,
  border = NA,
  col = 'grey',
  axes = F,
  xlim = c(0, 10000)
)

# 高亮部分柱子
domestic_price_vector <- price_brands$current_price*price_brands$domestic
barplot(
  domestic_price_vector,
  names.arg = F,
  horiz = T,
  border = NA,
  col = 'orange1',
  axes = F,
  add = T
)

# 添加坐标轴 
axis(side = 1, at=c(0, 2000, 4000, 6000, 8000, 10000),
     labels = c(0, 2, 4, 6, 8, '10 (千元)'),
     tick = F, cex.axis=0.6)
rect(0, -0.5, 5000, plot_rst[10] + plot_rst[1],
     col=rgb(191, 239, 255, 80, maxColorValue = 255), border = NA)
rect(5000, -0.5, 10000, plot_rst[10] + plot_rst[1],
     col=rgb(191, 239, 255, 120, maxColorValue = 255), border = NA)
