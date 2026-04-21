# 1、将R的内置数据集longley作为本次作业的数据集，
# 将longley数据集变量名为Year的列给删除掉。
data(longley)  # 加载内置数据集
longley_ <- longley[, colnames(longley) != "Year"]  # 删除Year列

# 2、画出数据集longley的散点图矩阵
pairs(longley_, 
      main = "longley数据集（删除Year后）散点图矩阵",
      pch = 16, col = "steelblue")

# 3、计算数据集longley的变量的相关系数，并将相关系数可视化。
corr1 <- cor(longley)
library(ggcorrplot)
ggcorrplot(corr1, lab=T, hc.order = T, type='lower')

# 4、画出f(x)=x^3+sin(x)的函数图像，自变量的取值范围是[0,10]

curve(x^3 + sin(x), from=0, to=10, n=1000,
      main=expression(x^3 + sin(x)),
      ylab = 'y')
