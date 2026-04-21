# absolute path
absolute_path <- "D:/Codez/R_Learning/02-系列教学1(BV1G84Uz3EgB)/01每天一点R语言（基础篇）已完结/R101/data_test_day4.csv"

# 改变工作路径
setwd("D:/Codez/R_Learning/02-系列教学1(BV1G84Uz3EgB)/01每天一点R语言（基础篇）已完结/R101")
# relative path
relative_path <- "./data_test_day4.csv"


# load data
BC_data <- read.csv(relative_path)

