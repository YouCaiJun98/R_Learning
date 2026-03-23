# 如何注释：Ctrl + Shift + C

# 什么是向量
c(1, 2, 3, 4, 5) + 1
# 如何创建向量
# char -> string
A <- c("A", "B", "C", "D")
# A = c("A", "B", "C", "D")

# 如何索引向量
A[3]

# 如何修改向量的值
A[4] <- "F"

# 如何扩展向量
A <- c(A, "E", "F")

# 什么是数据框
B <- c(1, 2, 3, 4, 5, 6)
# bool: T = True / 1; F = False / 0
C <- c(T, F, T, T, F, F)
D <- c(6, 5, 4, 3, 2, 1)

# 如何创建数据框
Df <- data.frame(A, B, C)


# 如何提取数据框的列
B <- B + 1
Df$B <- Df$B + 1

# 如何扩展数据框的列
Df <- data.frame(Df, D)


# 数据框的行名和列名
Df[3] # 列！一维索引
Df[2, 4] # 第二行第四列
Df[, 4] # 第四列！
Df[2, ] # 第二行

Df$C
rownames(Df) <- c('a', 'b', 'c', 'd', 'e', 'f')
Df['c', ]
Df[, "C"]
