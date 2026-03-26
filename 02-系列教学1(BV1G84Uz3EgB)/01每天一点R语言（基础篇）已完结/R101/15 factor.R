# 什么是factor
Group <- c(rep("A", 100), c(rep("B", 100)))
group <- factor(Group)

group <- factor(Group, labels=c("M", "W"))
