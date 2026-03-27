# 数据构造
age1 <- rnorm(n=100, mean=55, sd=10)
age2 <- rnorm(n=100, mean=75, sd=10)
Age <- c(age1, age2)
Group <- c(rep("A", 100), rep("B", 100))
group <- factor(Group)
df <- data.frame(Group, group, Age)

# 方法1
wilcox.test(age1, age2)
wilcox.test(age2, age1)

# 方法2
wilcox.test(df$Age ~ df$Group)
wilcox.test(df$Age ~ df$group)
