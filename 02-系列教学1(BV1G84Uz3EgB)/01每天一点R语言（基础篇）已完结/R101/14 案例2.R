# 数据读入
data <- read.csv('./data_case_day7_BMI.csv')

# 数据筛选
data_sub <- data[data$BMI >= 24 & !is.na(data$BMI), ]

# 进一步数据处理，判断是否大于28 
data_sub$obe <- ifelse(data_sub$BMI > 28, 1, 0)
table(data_sub$obe)

# 数据分析 - 对obesity人群分析四分位距
quantile(data_sub$BMI[data_sub$obe == 1])

# Q: 为什么quantile(data_sub$BMI[data_sub$obe])是错的呢？
# quantile(data_sub$BMI[data_sub$obe])

quantile(data_sub$BMI[data_sub$obe == 0])

write.csv(data_sub, './data_case_day14.csv', row.names=F)

