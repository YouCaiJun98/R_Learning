library(tidyverse)

# 数据读取
data <- read_csv('./data_case_day20.csv')

# 数据排序
data %>% arrange(Age) %>% head() # 升序
data %>% arrange(desc(Age)) %>% head() # 降序
data %>% arrange(Stage, desc(Age)) %>% head() # 多变量排序

# 数据抽样
data_sub1 <- data %>%  sample_frac(0.3) # 按比例抽样
data_sub2 <- data %>%  sample_n(50) # 按数量抽样
