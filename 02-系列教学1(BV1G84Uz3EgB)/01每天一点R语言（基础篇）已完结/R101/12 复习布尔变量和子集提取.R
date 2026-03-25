# 构建数据
a <- 1:100
b <- c(rep("A", 30), rep("B", 30), NA, rep("C", 39))
df <- data.frame(a, b)

# b不缺失
df_sub1 <- df[!is.na(df$b), ]

# a介于45到50岁
df_sub2 <- df[df$a>=45 & df$a<=50, ]

# b不缺失且不为A
df_sub3 <- df[!is.na(df$b) & df$b != "A", ]

# a大于50且b不为B
df_sub4 <- df[df$a > 50 & df$b != "B",] # 有缺失！
df_sub4_ <- df[df$a > 50 & df$b != "B" & !is.na(df$b),]

# a大于50且b为B
df_sub5 <- df[df$a > 50 & df$b == "B",] # 有缺失！
df_sub5_ <- df[df$a > 50 & df$b == "B" & !is.na(df$b),]

