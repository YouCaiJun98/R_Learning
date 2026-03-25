# for循环
a <- c()
for (i in 1:100) {
  a <- c(a, i ^ 2)
}
a[1:10]


for (j in c("A", "B")) {
  print(j)
}

# while循环
i <- 1
while (i < 5) {
  cat("当前i：", i, "\n")
  i <- i + 1  # 必须更新，否则死循环
}

# repeat循环
sum <- 0
repeat {
  sum <- sum + 2
  cat("当前和：", sum, "\n")
  if (sum > 10) break  # 终止循环
}
