# 数据导入
library(tidyverse)
library(broom)
data = read.csv("./data/metabric_cleaned_1500.csv")

# 核心变量选择 & 分类与连续变量处理
data_analysis <- data %>% select(PATIENT_ID, TreatmentOutcome, AGE_AT_DIAGNOSIS,
                                 LATERALITY, ER_STATUS, HER2_STATUS, TUMOR_STAGE) %>% 
  mutate(TreatmentOutcome = factor(TreatmentOutcome),
         LATERALITY = factor(LATERALITY),
         ER_STATUS = factor(ER_STATUS),
         HER2_STATUS = factor(HER2_STATUS),
         TUMOR_STAGE = factor(TUMOR_STAGE))

# 数据清理 - 删除含有NA的行
data_analysis <- data_analysis %>% drop_na(LATERALITY, HER2_STATUS, TUMOR_STAGE)

# 多因素建模
model_multi <- glm(TreatmentOutcome ~ AGE_AT_DIAGNOSIS +
                     ER_STATUS + 
                     HER2_STATUS + 
                     TUMOR_STAGE, family = binomial(), data = data_analysis)
summary(model_multi)

# 提取数据并分析
C1 <- exp(model_multi[["coefficients"]])
C2 <- exp(confint(model_multi))[,1]
C3 <- exp(confint(model_multi))[,2]
P <- summary(model_multi)$coefficients[,4]

# 结果打包
result <- data.frame(C1, C2, C3, P)
names(result) <- c("OR", "LCI", "UCI", "P")
result



