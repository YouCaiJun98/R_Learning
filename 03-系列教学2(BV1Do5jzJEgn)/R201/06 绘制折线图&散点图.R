# 导入数据
library(readxl)
stock <- read_excel('./data/stock.xlsx')

# 绘制折线图
plot(stock$time, stock$SH_closing_price, type='l', ylim=c(20000, 40000))
abline(h=30000, v=as.POSIXct("2021-10-3"),lty=4, col='red')
lines(stock$time, stock$SZ_closing_price, lty=2)

## 横坐标排序后绘制折线图
stock_new <- stock[order(stock$SH_closing_price), ]
plot(stock_new$SH_closing_price, stock_new$investor_confidence_index, type='l')

## 更简单的方法
matplot(stock$time, stock[, 2:4], lty = 1:3, type = 'l', col='black')


# 绘制散点图
## 追加分类变量
stock$label <- ifelse(stock$SH_closing_price < 30000, 1, 2)
stock[c('SH_closing_price', 'label')]
stock1 <- subset(stock, label == 1)
stock2 <- subset(stock, label == 2)
plot(stock1$SH_closing_price, stock1$investor_confidence_index, pch = 16,
     col = 'blue', xlim = range(stock$SH_closing_price),
     ylim = range(stock$investor_confidence_index))
points(stock2$SH_closing_price, stock2$investor_confidence_index,
       pch=17, col='green')
## 更简单的方法
c('blue', 'green')[c(1, 2, 1, 2)]
plot(stock$SH_closing_price, stock$investor_confidence_index,
     col = c('blue', 'green')[stock$label],
     pch = c(16, 17)[stock$label])
