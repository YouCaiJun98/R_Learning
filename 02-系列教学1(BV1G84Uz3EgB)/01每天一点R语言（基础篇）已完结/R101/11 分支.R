# for循环
a <- c()
for (i in 1:100) {
  a <- c(a, i ^ 2)
}
a[1:10]


for (j in c("A", "B")) {
  print(j)
}


# if else
if (2 > 1) {
  a <- 1
} else {
  a <- 3
}


# ifelse
ifelse(2 < 1, a <- 2, a <- 3)
a <- ifelse(2 < 1, 2, 3)

# 条件判断下的循环
for (i in 1:100) {
  if (i < 18 && i > 5) {
    a <- c(a, i)
  }
}

# 更方便的子集提取
b <- 1:100 
b[b<=70 & b >=18]
