library(tidyverse)

# 数据导入
data <- read.csv("./data/metabric_cleaned_1500.csv")

# 核心变量选择 & 分类与连续变量处理
data_analysis <- data %>% select(PATIENT_ID, TreatmentOutcome, AGE_AT_DIAGNOSIS,
                          LATERALITY, ER_STATUS, HER2_STATUS, TUMOR_STAGE) %>% 
                          mutate(TreatmentOutcome = factor(TreatmentOutcome),
                                 LATERALITY = factor(LATERALITY),
                                 ER_STATUS = factor(ER_STATUS),
                                 HER2_STATUS = factor(HER2_STATUS),
                                 TUMOR_STAGE = factor(TUMOR_STAGE))


# 缺失值概览
data_analysis %>% summarise(across(everything(), ~ sum(is.na(.)))) %>% 
                  pivot_longer(everything(), names_to = "variable", values_to = "n_missing") %>% 
                  mutate(p_missing = n_missing / 1500) %>% 
                  filter(p_missing > 0.05)

# 分组描述
dataTemp <- data_analysis[data_analysis$TreatmentOutcome == 0, ]
## 连续型变量描述
mean(dataTemp$AGE_AT_DIAGNOSIS)
sd(dataTemp$AGE_AT_DIAGNOSIS)
quantile(dataTemp$AGE_AT_DIAGNOSIS)
## 分类变量描述
table(dataTemp$TUMOR_STAGE, useNA = "ifany")


