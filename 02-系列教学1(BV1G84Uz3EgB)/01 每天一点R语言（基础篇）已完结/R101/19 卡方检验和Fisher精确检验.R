Path <- c(rep(c("SC", "AC", "C", "Other"), 10), rep(c("SC", "AC", "C", "C", "C", "Other","Other", "Other"), 20))
Group <- c(rep("A", 100), rep("B", 100))

df <- data.frame(Group, Path)

table(df$Group)
table(df$Path)
# 生成列联表
table(df$Group, df$Path)
# table(Group, Path) # 这样也是可以的！

# 卡方检验
chisq.test(table(df$Group, df$Path))
# Fisher精确检验
fisher.test(table(df$Group, df$Path))
