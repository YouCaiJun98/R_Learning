data <- read.csv('./data_case_day20.csv')

# 描述性统计
table(data$pCR)
## 基础数据描述性统计
mean(data$Age); sd(data$Age)
quantile(data$Age)

table(data$Stage)

table(data$Subtype)
# table(data$Subtype, useNA = "ifAny")

# 分组统计
data_pCR <- data[data$pCR == 1, ]
data_nonpCR <- data[data$pCR == 0, ]

## pCR组描述性统计
mean(data_pCR$Age); sd(data_pCR$Age)
quantile(data_pCR$Age)
table(data_pCR$Stage)
table(data_pCR$Subtype)

## 非pCR组描述性统计
mean(data_nonpCR$Age); sd(data_nonpCR$Age)
quantile(data_nonpCR$Age)
table(data_nonpCR$Stage)
table(data_nonpCR$Subtype)

# 假设检验
wilcox.test(data$Age ~ data$pCR)
wilcox.test(as.numeric(factor(data$Stage)) ~ data$pCR)
fisher.test(table(data$pCR, data$Subtype))


