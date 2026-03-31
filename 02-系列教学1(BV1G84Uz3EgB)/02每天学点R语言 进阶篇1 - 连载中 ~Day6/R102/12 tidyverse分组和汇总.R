library(tidyverse)

# 数据读取
data <- read_csv('./data_case_day20.csv')

# 数据分组
data_result <- data %>% group_by(pCR) %>%  summarize(N = n())
data_result2 <- data %>% group_by(pCR) %>%  summarize(N = n(), 
                                                      Age_mean=mean(Age))
data_result3 <- data %>% group_by(pCR) %>%  summarize(N = n(), 
                                    Age_mean=mean(Age), Age_sd=sd(Age))
data_result4 <- data %>% group_by(pCR) %>%  summarize(N = n(), 
  Age_mean=mean(Age), Age_sd=sd(Age), 
  Age_str=paste(round(Age_mean, 2), round(Age_sd, 2), sep="±"))
