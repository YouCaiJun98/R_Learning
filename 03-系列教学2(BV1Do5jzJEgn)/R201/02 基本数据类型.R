# 向量创建
## 创建数值型向量
num1 <- c(9.1, 8.2, 7.3)
num2 <- 1:10
num3 <- c('first'=9.1, 'second'=8.2, 'third'=7.3)

## 创建字符型向量
char <- c('a', 'b', "c")

## 创建逻辑型向量
logit <- c(TRUE, FALSE, T, F)

## 创建混合类型向量
c(1, 'a', TRUE)

## 创建因子向量
sex <- c('F', 'M', 'F', 'M')
sexf <- factor(sex)

# 向量索引
num1[1]           # 整数索引
num1[c(1, 3)]     # 向量索引
num1[c(T, F, T)]  # 逻辑索引
num1[-2]          # 负数索引
num3[c('first', 'third')] # 字符索引

## 一个稍微复杂一点的例子：取一段数据内的偶数
a <- 20:30
a[a%%2 == 0]

# 元素修改
num1[1] <- 5.6 # 单元素修改
num1[c(1, 3)] <- c(7.8, 3.6) # 多元素修改

# 类型查看
class(num1)
class(char)
class(logit)
class(sexf)

# 类型检查与转换
is.character(num1)
num1 <- as.character(num1)
class(num1)

is.character(char)
is.character(logit)
as.character(logit)

is.numeric()
as.numeric()

is.logical()
as.logical(c(0,1,2))
as.logical(c('a', 'b', '0'))

# 特殊数值
b <- (c(NA, 0/1, sqrt(-1), 1/0, -1/0))
is.na(b)
is.finite(b)
is.infinite(b)
