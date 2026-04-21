# 1、导入数据集returndaily.xlsx，将生成的数据框命名成returndaily
library(readxl)
returndaily <- read_excel('./data/returndaily.xlsx')

# 2、画出returndaily数据集的变量sz_return_daily的直方图和核密度图。
x <- returndaily$SZ_return_daily
# 直方图
y <- hist(x)

# 核密度图
z <- density(x)
plot(z)

# 3、查看变量sz_return_daily的均值、方差、标准差、偏度、峰度、
# 判断变量是否是正态分布。
mean(x)
var(x)
sd(x)
skewness(x)
kurtosis(x)
jarqueberaTest(x)