library(readxl)
stock <- read_excel("./data/stock.xlsx")

# 基线绘制方法
plot(stock$date, stock$SH_closing_price, type='l', ylim=c(20, 5000))
lines(stock$date, stock$investor_confidence_index, lty=2)

# 画到两张图上去
par(mfrow=c(1,2))
plot(stock$date, stock$SH_closing_price, type = 'l',xlab = '时间',
     ylab = '上证指数收盘价')
plot(stock$date, stock$investor_confidence_index, type = 'l',
     xlab = '时间', ylab = '投资者信心指数')

# 双坐标图
## 基础绘图（后续慢慢优化） - 刻度、标签叠加
plot(stock$date, stock$SH_closing_price, type = "l")
par(new=T)
plot(stock$date, stock$investor_confidence_index, type = "l", lty=2)

## 优化1 - 取消刻度、标签的叠加
plot(stock$date, stock$SH_closing_price, type = "l")
par(new=T)
plot(stock$date, stock$investor_confidence_index, type = "l", lty=2, ann=F,
     yaxt='n')

## 一个小例子
plot(1:5, ann=F, xaxt='n', yaxt='n')
axis(side=2, at=c(3, 3.5, 4))

## 优化2 - 调节次轴刻度
par(mar=c(5,4,4,4))
plot(stock$date, stock$SH_closing_price, type = "l",
     ylab='上证指数收盘价', main='投资者信心指数VS上证指数收盘价')
par(new=T)
plot(stock$date, stock$investor_confidence_index, type = "l", lty=2, ann=F,
     yaxt='n')
axis(side=4)
mtext(text = '投资者信心指数', side=4, line=2)
legend('topright', legend=c('SH收盘价', '信心指数'), lty=c(1,2), bty='n')
