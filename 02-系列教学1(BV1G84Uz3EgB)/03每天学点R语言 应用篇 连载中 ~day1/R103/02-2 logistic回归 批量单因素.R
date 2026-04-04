library(broom)
library(tidyverse)

# 数据导入
data <- read.csv("./data/metabric_cleaned_1500.csv")

## 核心变量选择 & 分类与连续变量处理
data_analysis <- data %>% select(PATIENT_ID, TreatmentOutcome, AGE_AT_DIAGNOSIS,
                                 LATERALITY, ER_STATUS, HER2_STATUS, TUMOR_STAGE) %>% 
  mutate(TreatmentOutcome = factor(TreatmentOutcome),
         LATERALITY = factor(LATERALITY),
         ER_STATUS = factor(ER_STATUS),
         HER2_STATUS = factor(HER2_STATUS),
         TUMOR_STAGE = factor(TUMOR_STAGE))

## 数据清理 - 删除含有NA的行
data_analysis <- data_analysis %>% drop_na(LATERALITY, HER2_STATUS, TUMOR_STAGE)

## 提取自变量
predictors <- c("AGE_AT_DIAGNOSIS", "LATERALITY", "ER_STATUS", "HER2_STATUS",
                "TUMOR_STAGE")

## 建模
map_dfr(predictors, \(x){
  f <- as.formula(paste0("TreatmentOutcome ~ ", x))
  fit <- glm(f, family = binomial(), data=data_analysis)
  
  broom::tidy(fit, conf.int=T, exponentiate=T) %>% filter(term != "(Intercept)")
})

