library(tidyverse)
# 数据读取
data <- read_csv('./data_case_day20.csv')
data_df <- read.csv('./data_case_day20.csv')

class(data)
class(data_df)

# 数据查看
glimpse(data)
glimpse(data_df)
