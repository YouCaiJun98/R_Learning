library(tidyverse)

# 数据读取
data <- read_csv('./data_case_day20.csv')

# 数据选择
## 方法1
select(data, PID)
## 方法2
data_sub <- data %>% select(PID, pCR, Age) %>% select(PID, Age)
## 补充：传入参数的顺序
# func(arg1, arg2, arg3)
# func(..., arg2, arg3)

# 数据过滤
data_sub2 <- data_sub %>% dplyr::filter(Age <= 40)

# base R
data_sub3 <- data[data$Age <= 40, c("pCR", "Age")]
