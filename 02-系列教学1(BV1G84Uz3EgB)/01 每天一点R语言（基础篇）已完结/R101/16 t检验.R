# 数据构造
age1 <- rnorm(n=100, mean=55, sd=10)
age2 <- rnorm(n=100, mean=75, sd=10)

# 方法1
t.test(age1, age2)


# 方法2
Group <- c(rep("A", 100), c(rep("B", 100)))
Age <- c(age1, age2)
df <- data.frame(Group, Age)

t.test(df$Age ~ df$Group) # 看Age关于Group的变化情况
# 更规范的方式
group <- factor(Group)
df2 <- data.frame(group, Age)
t.test(df2$Age ~ df2$group)
