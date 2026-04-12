library(readxl)
returndaily <- read_excel('./data/returndaily.xlsx')
x <- returndaily$SH_return_daily

# 绘制直方图
y <- hist(x)
y <- hist(x, breaks=10) # 这样对分组的控制不是很好
x_breaks <- seq(min(x), max(x), length.out=10) # 精准控制分组
x_breaks <- seq(min(x), max(x), freq=F) # y轴改成密度

# 访问hist统计出的数值
y$breaks[2] - y$breaks[1] # 计算各个单元格的长度
y$counts
y$density
y$density * (y$breaks[2] - y$breaks[1]) # 计算每个单元格对应的概率
sum(y$density * (y$breaks[2] - y$breaks[1])) # 概率之和为1

# 绘制核密度图
z <- density(x)
plot(z)

z <- density(x, bw=0.001) # 修改带宽
plot(z)

# 将直方图与核密度图画在一起
y <- hist(x, col='red', border='white')
lines(density(x), col='blue')

# 生成正态分布数据并绘图，再对比
a <- rnorm(10000, 0, 1)
par(mfrow=c(1,2))
hist(x, breaks=10, freq=F, col='red', border='white')
lines(density(x), col='blue')
hist(a, freq=F, breaks=100, main='正态分布', col='red', border='white')
lines(density(a, bw=0.5), col='blue')

# 统计量
library(fBasics)
skewness(x)
kurtosis(x)
jar <- jarqueberaTest(x)
jar@test$p.value

# 封装为函数
describe <- function(x){
  m <- mean(x)
  v <- var(x)
  s <- sd(x)
  ske <- skewness(x)
  kur <- kurtosis(x)
  jar <- jarqueberaTest(x)
  p <- jar@test$p.value
  return(c('均值'=m, '方差'=v, '标准差'=s,
           '偏度'=ske, '峰度'=kur, 'p值'=p))
}
describe(x)
describe(a)
