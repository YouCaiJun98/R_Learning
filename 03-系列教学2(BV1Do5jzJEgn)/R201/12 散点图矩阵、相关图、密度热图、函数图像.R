# 散点图矩阵
mdata <- mtcars[c('mpg', "disp", "hp", "drat", "wt")]
pairs(mdata, col='blue', pch=16, upper.panel = NULL) # 只显示下三角
pairs(mdata, col='blue', pch=16, lower.panel = NULL) # 只显示上三角

## 自定义函数
panelfunc <- function(x, y) {
  points(x, y, col='blue')
  abline(lm(y~x), col='green')
}
## 线性拟合
pairs(mdata, panel=panelfunc)

## 复杂散点图
library(car)
spm(mdata)
spm(mdata, smooth=F) # 不画拟合曲线
spm(mdata, smooth=F, diagonal=list(method='histogram')) # 对角线画直方图

# 相关图像
corr1 <- cor(mdata) # 皮尔逊相关系数
cor(mdata, method="spearman") # spearman相关系数
cor(mdata, method="kendall") # kendall相关系数
library(ggcorrplot)
ggcorrplot(corr1, lab=T, hc.order = T, type='lower')

# 散点密度热图
a <- rnorm(5000, 0, 1)
b <- rnorm(5000, 0, 3)
smoothScatter(a, b, cex=2)
smoothScatter(a, b, cex=2, nrpoints = 4) # 查看密度最小的4个点
smoothScatter(a, b, cex=2, nrpoints = Inf) # 查看所有点（密恐警告！）
plot(a, b, col=densCols(a, b), pch=20, cex=1.5) # 用plot画散点密度图
plot(a, b, col=densCols(a, b, colramp = colorRampPalette(c('yellow', 'red'))),
     pch=20, cex=1.5) # 改变颜色

# 函数图像
curve(log(x) + sqrt(x) + x^2, from=1, to=100, n=1000,
      main=expression(log(x) + sqrt(x) + x^2),
      ylab = 'y')
