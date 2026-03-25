# 读取数据
data_BC_BMI = read.csv('./data_case_day7.csv', row.names=1)
data_BC_BMI["P004", ]


# 提取数据
data_BC_BMI$W
data_BC_BMI$H

# 做向量运算
BMI = data_BC_BMI$W / data_BC_BMI$H ^ 2

# 将BMI存到数据框中
data_BC_BMI = data.frame(data_BC_BMI, BMI)
## 方法二
# data_BC_BMI$BMI = BMI

# 数据导出
write.csv(data_BC_BMI, "./data_case_day7_BMI.csv")
