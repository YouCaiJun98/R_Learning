colors()

# 内置颜色可视化
a <- 1:26
b <- 1:26
d <- merge(a, b)[1:657, ]
plot(d$x, d$y, col=colors(), cex=3, pch=15)
for (i in 1:26) {
  for (j in 1:26) {
    text(i, j, labels=i+(j-1)*26, cex=0.5)
  }
}

# 使用内置颜色
plot(1:10, col=colors()[26], pch=15, cex=4)

# 调色板
rainbow()
heat.colors()
terrain.colors()
topo.colors()

## 彩虹调色板
plot(1:10, rep(1, 10), col=rainbow(10, alpha=0.5), pch=15, cex=5)
## 热图调色板
plot(1:10, rep(1, 10), col=heat.colors(10), pch=15, cex=5)
## 地形图调色板
plot(1:10, rep(1, 10), col=terrain.colors(10), pch=15, cex=5)
## topo调色板
plot(1:10, rep(1, 10), col=topo.colors(10), pch=15, cex=5)
## cm调色板
plot(1:10, rep(1, 10), col=cm.colors(10), pch=15, cex=5)

# 扩展颜色
col1 <- colorRampPalette(c('yellow', 'red'))(50)
plot(1:50, col=col1, pch=16, cex=2)

## mtcars示例
mtcars <- mtcars[order(mtcars$wt), ]
plot(mtcars$wt, mtcars$disp, col=col1, pch=16, cex=2)

# 配色方案
library(RColorBrewer)
display.brewer.all()
col2 <- brewer.pal(3, 'Accent')
plot(1:8, rep(1,8), col=col2, pch=16, cex=2)

# 配色方案 - HSV
library(colorspace)
hcl_palettes(plot = T)
col3 <- qualitative_hcl(8, 'warm')
plot(1:8, rep(1,8), col=col3, pch=16, cex=2)
col4 <- sequential_hcl(8, 'grays')
plot(1:8, rep(1,8), col=col4, pch=16, cex=2)
col5 <- diverge_hcl(8, 'blue-red')
plot(1:8, rep(1,8), col=col5, pch=16, cex=2)