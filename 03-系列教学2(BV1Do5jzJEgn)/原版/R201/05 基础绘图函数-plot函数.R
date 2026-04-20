# 绘制向量图像（下标是index，纵坐标是向量值）
plot(mtcars$wt)

# 绘制数据框图像
plot(mtcars[, 1:2])
plot(mtcars)

par()

# 修改绘图函数的参数 - 绘图类型
plot(mtcars$wt, mtcars$disp, type='p') # 散点图
plot(mtcars$wt, mtcars$disp, type='l') # 折线图
plot(mtcars$wt, mtcars$disp, type='b') # 点线图

mtcars <- mtcars[order(mtcars$wt),]
plot(mtcars$wt, mtcars$disp, type='o') # 点线图，但是点在下，线在上
plot(mtcars$wt, mtcars$disp, type='h') # 竖线图

opar <- par(no.readonly = T) # 保存原始全局设置
par(mfrow=c(3, 3)) # 绘制三行三列的子图，按行排列
# 批量绘图
for (i in c('p', 'l', 'b', 'c', 'o', 'h', 's', 'n')) {
  plot(mtcars$wt, mtcars$disp, type = i, main = paste('type', i))
}

# 散点图参数设置
## PCH参数
plot(mtcars$wt, mtcars$disp, pch=2) # 散点图，三角点
## CEX参数
plot(mtcars$wt, mtcars$disp, cex=1.5) # 散点图，大点

# 折线图参数设置
## lty参数
plot(mtcars$wt, mtcars$disp, type='l', lty=3) 
## lwd参数
plot(mtcars$wt, mtcars$disp, type='l', lwd=3) 

# 颜色控制
plot(mtcars$wt, mtcars$disp, type='l', col='blue')  # 颜色名称
plot(mtcars$wt, mtcars$disp, type='l', col=4) # 颜色编号
plot(mtcars$wt, mtcars$disp, type='l', col='#0000FF')  # 颜色十六进制值
plot(mtcars$wt, mtcars$disp, type='l', col=rgb(0, 0, 1))  # RGB形式
plot(mtcars$wt, mtcars$disp, type='l', col=hsv(h=240/360, s=1, v=1))  # HSV形式

# xlim & ylim参数设置
plot(mtcars$wt, mtcars$disp, xlim=c(2,4), ylim=c(100,400))

# 图像标题
## 在绘图函数中设置
plot(mtcars$wt, mtcars$disp, xlim=c(2,4), ylim=c(100,400),
     main='Motor Trend Car Road Tests', sub='2026-4-11',
     xlab='wt', ylab='disp')
## 在绘图函数外设置
plot(mtcars$wt, mtcars$disp, xlim=c(2,4), ylim=c(100,400),
     ann = F)
title(main='Motor Trend Car Road Tests', sub='2026-4-11',
      xlab='wt', ylab='disp')
