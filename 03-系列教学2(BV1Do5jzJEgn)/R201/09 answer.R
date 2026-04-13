# 1、从RColorBrewer包里选择自己喜欢的配色方案
library(RColorBrewer)
pal <- brewer.pal(n = 9, name = "Blues")

# 2、把选中的颜色扩展出30个颜色
col_30 <- colorRampPalette(pal)(30)

# 3、绘制出如下图像，纵坐标的取值都是2，横坐标的取值是1到30。
# 点的颜色是刚刚生成的30种颜色
plot(x = 1:30, y = rep(2, 30), 
     pch = 16, cex = 3,  # 大圆点
     col = col_30,       # 30种渐变颜色
     main = "30色渐变展示",
     xlab = "颜色序号", ylab = "",
     axes = FALSE)
axis(side = 1, at = 1:30)  # 仅显示x轴刻度


# 4、用内置数据集mtcars绘制如下图像，横坐标是变量wt,纵坐标是变量disp
# ，hp的值越大点的颜色越深。
col_mtcars <- colorRampPalette(brewer.pal(9, "Blues"))(length(unique(mtcars$hp)))
col_idx <- cut(mtcars$hp, breaks = length(unique(mtcars$hp)), labels = FALSE)

plot(mtcars$wt, mtcars$disp,
     pch = 16, cex = 1.5,
     col = col_mtcars[col_idx],
     main = "mtcars: wt vs disp (hp越深颜色越深)",
     xlab = "wt (车重)", ylab = "disp (排量)")