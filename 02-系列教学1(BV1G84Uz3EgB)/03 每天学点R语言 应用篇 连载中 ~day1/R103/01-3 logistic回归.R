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
## 连续变量
data_analysis %>% group_by(TreatmentOutcome) %>% 
      summarise(N = n(), Age_mean = mean(AGE_AT_DIAGNOSIS, na.rm=T),
                Age_std = sd(AGE_AT_DIAGNOSIS, na.rm=T),
                Age_median = median(AGE_AT_DIAGNOSIS, na.rm=T))
### 分类变量
cat_by_outcome = function(var) {
  data_analysis %>% count(TreatmentOutcome, {{var}}) %>% 
    group_by(TreatmentOutcome) %>% mutate(prop = n / sum(n)) %>% ungroup()
}
cat_by_outcome(var=LATERALITY)

