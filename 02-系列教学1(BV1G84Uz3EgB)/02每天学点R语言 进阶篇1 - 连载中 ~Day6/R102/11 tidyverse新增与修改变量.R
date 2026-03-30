library(tidyverse)

# 数据读取
data <- read_csv('./data_case_day20.csv')

# 修改变量
data_new <- data %>% mutate(age_idx = Age * Age) %>% 
  mutate(age_idx = if_else(condition = age_idx < 1000, true=1000, false=age_idx))

# base R
data_base <- data.frame(data, age_index = data$Age * data$Age)
data_base$age_index[data_base$age_index < 1000] = 1000
