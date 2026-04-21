# 矩阵
## 矩阵初始化
m <- matrix(1:6, nrow=2, ncol=3, # byrow=T, # 是否按行排列
            dimnames=list(c('r1', 'r2'), c('c1', 'c2', 'c3')))
class(m)
## 矩阵元素访问 - 数值型
m[1, 1]
m[1, ]
m[, 1]
## 矩阵元素访问 - 逻辑型
m[c(T, F), ]
## 矩阵元素访问 - 名称
m['r1', ]
m[, c('c1', 'c2')]
## 矩阵元素修改
m[1, ] <- c(12, 13, 14)
m[1, ] <- 100
## 矩阵转置
t(m)

# 数组
## 数组初始化
array(1:10)
array(1:10, dim = c(2, 5))
dim1 <- c("A1", "A2", "A3", "A4")
dim2 <- c("B1", "B2", "B3")
dim3 <- c("C1", "C2")
arr <- array(1:24, c(4,3,2), dimnames = list(dim1, dim2, dim3))
## 数组元素访问 - 名称
arr[,,'C1']
## 数组元素访问 - 整数
arr[,,1]
## 数组元素访问 - 逻辑型
arr[c(T, T, F, F), ,]

# 数据框
student <- data.frame(ID=c(1001, 1002, 1003),
                      NAME=c('Alice', 'Bob', 'Charlie'),
                      GENDER=c('F', 'M', 'M'))
## 数据框元素访问 - 整数
student[1, 1]
student[1, ]
student[, 1]
## 数据框元素访问 - 名称
student[, 'ID']
student['ID']
## 数据框元素访问 - 名称向量
student[c('ID', 'NAME')]

# 列表
lst <- list(a=1, b='char', c=m, d=student)
## 列表元素的访问 - 整数
lst[[1]]
## 列表元素的访问 - 名称
lst[['a']]
lst['a'] # 返回一个列表
