library(tidyverse)

# 数据读取
data <- read_csv('./data_case_day20.csv')

# 修改列名
data %>% rename(PatientID = PID, Response = pCR)

# 合并数据
## 纵向合并（按照行来合并）
data_new1 <- data.frame(
  PID = c("P201", "P202"),
  pCR = c(1, 0),
  Age = c(30, 40),
  Stage = c("II", "III"),
  Subtype = c("HR+HER2+", "TN")
)
### tidyverse实现方式
data_merged <- bind_rows(data, data_new1)
### Base R实现方式
data_merged_ <- rbind(data, data_new1)
### 可以配合管道符实现复杂的filter&bind
data_filtered_and_merged <- data %>% filter(Age < 50) %>% bind_rows(data_new1)

## 横向合并
data_new2 <- data.frame(
  PID = c("P001", "P002", "P003", "P004"),
  SurvivalMonths = c(36, 24, 48, 12)
)

data %>% left_join(data_new2, by = "PID")

## 多表连接
data_new3 <- data.frame(
    PID = c("P001", "P003", "P005"),
    Regimen = c("Chemo", "Targeted", "Immunotherapy")
)

data %>% left_join(data_new2, by = "PID") %>% left_join(data_new3, by = "PID")

