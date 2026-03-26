# 构建数据
a <- 1:100
# a <- c(1:99, NA)
b <- c(rep("A", 30), rep("B", 30), NA, rep("C", 39))
df <- data.frame(a, b)

# 数值型
## 均值
mean(a)
mean(a, na.rm=T) # 移除NA
## 标准差
sd(a)

## 中位数
median(a)

## 四分位距
quantile(a)

# 分类变量
## 个数
table(b)
n_b <- table(b, useNA="ifany")
n_b / length(b)


## 百分比

