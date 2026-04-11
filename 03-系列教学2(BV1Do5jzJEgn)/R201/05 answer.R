# 1、利用mtcars数据集画出散点图，横坐标是变量mpg，纵坐标是变量qsec
plot(mtcars$mpg, mtcars$qsec)
# 2、修改上图中点的样式，将点的样式分别设置成1到16。
# 最后展示成一页多图的形式。示例如下。
opar <- par(no.readonly = T) # 保存原始全局设置
par(mfrow = c(4, 4)) 
for(i in 1:16) {
  plot(mtcars$mpg, mtcars$qsec,
       pch = i)
}

# 3、导入stock.xlsx数据集，生成数据框stock
library(readxl)
par(opar)
stock <- read_excel("./data/stock.xlsx")
# 4、利用stock数据集，画出投资者信心指数（investor_confidence_index）的折线图。
# 横坐标是时间，纵坐标是投资者信心指数（investor_confidence_index）。
# 同时添加标题、横纵坐标标签。
plot(stock$time, stock$investor_confidence_index,
     type = "l",
     main = "投资者信心指数走势",
     xlab = "时间",
     ylab = "投资者信心指数",
) 