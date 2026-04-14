# 简单气泡图
symbols(mtcars$disp, mtcars$wt, circles = mtcars$mpg)
symbols(mtcars$disp, mtcars$wt, squares = mtcars$mpg) # 方块

symbols(mtcars$disp, mtcars$wt, circles = mtcars$mpg, inches = F)
symbols(mtcars$disp, mtcars$wt, circles = mtcars$mpg, inches = 0.35) # 缩放圆圈
symbols(mtcars$disp, mtcars$wt, circles = sqrt(mtcars$mpg), inches = 0.35) # 缩放圆圈

symbols(mtcars$disp, mtcars$wt, circles = sqrt(mtcars$mpg), inches = 0.35,
        bg='red', fg='green') # 改变颜色

n <- nrow(mtcars)
heatcols <- heat.colors(n)
barplot(rep(1, n), col=heatcols) # 颜色可视化
# mtcars重新排列
mtcars <- mtcars[order(mtcars$mpg, decreasing = T),]
mtcars
symbols(mtcars$disp, mtcars$wt, circles = sqrt(mtcars$mpg), inches = 0.35,
        bg=heatcols, fg=heatcols) # 热力图颜色

heatcols <- heat.colors(n+2, alpha = 0.6)
symbols(mtcars$disp, mtcars$wt, circles = sqrt(mtcars$mpg), inches = 0.35,
        bg=heatcols, fg=heatcols) # 增大透明度，减少遮挡

# 添加辅助线
mdisp <- mean(mtcars$disp)
mwt <- mean(mtcars$wt)
symbols(mtcars$disp, mtcars$wt, circles = sqrt(mtcars$mpg), inches = 0.35,
        bg=heatcols, fg=heatcols) # 增大透明度，减少遮挡
abline(v = mdisp, h=mwt, col='grey', lty=2)

# 不同区域对应不同颜色
library(dplyr)
mtcars['disp_wt_class'] <- case_when(mtcars$disp > mdisp & mtcars$wt > mwt ~ 1,
                                     mtcars$disp < mdisp & mtcars$wt > mwt ~ 2,
                                     mtcars$disp < mdisp & mtcars$wt < mwt ~ 3,
                                     mtcars$disp > mdisp & mtcars$wt < mwt ~ 4)
library(RColorBrewer)
piyg<-brewer.pal(5, "PiYG")
barplot(rep(1, 5), col=piyg,names.arg=1:5)
col1 <- piyg[1]
col2 <- piyg[2]
col3 <- piyg[5]
col4 <- piyg[4]
symbols(mtcars$disp, mtcars$wt, circles = sqrt(mtcars$mpg), inches = 0.35,
        bg=c(col1, col2, col3, col4)[mtcars$disp_wt_class], fg='white',
        xlab='disp', ylab='wt', main='气泡图') # 改变颜色
abline(v = mdisp, h=mwt, col='grey', lty=2)