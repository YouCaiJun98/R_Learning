# 数据创建
a <- c(1, 2, 3, NA, 5)
b <- c('A', 'B', 'B', 'B', 'E')
d <- 1:5 # 等效于c(1, 2, 3, 4, 5)

df <- data.frame(a, b, d)

# 子集提取方式1
## 序号（用索引提取）
df[1, 3] # 第一行第三个元素
df[1, ]  # 第一行元素
df[, 1]  # 第一列元素

## 列名提取
df$a
df[, "a"]

# 子集提取方式2
## bool向量提取
idx_b_row <- c(T, T, F, F, T)
b_ <- b[idx_b]

idx_row <- c(T, T, F, F, T)
idx_col <- c(F, T, T)
df[idx_row, idx_col]

# 带有条件判断的提取
df[df$d>2.5, ]
df[df$b!='B', ]
