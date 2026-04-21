library(tidyverse)

# 数据导入
data <- read.csv("./data/metabric_cleaned_1500.csv")

# 核心变量选择
data_analysis <- data.frame(PATIENT_ID = data$PATIENT_ID,
                            TreatmentOutcome = data$TreatmentOutcome,
                            AGE_AT_DIAGNOSIS = data$AGE_AT_DIAGNOSIS,
                            LATERALITY = data$LATERALITY,
                            ER_STATUS = data$ER_STATUS,
                            HER2_STATUS = data$HER2_STATUS,
                            TUMOR_STAGE = data$TUMOR_STAGE)

# 分类与连续变量处理
glimpse(data_analysis)
## 分类变量转换为factor
data_analysis$TreatmentOutcome = factor(data_analysis$TreatmentOutcome)
data_analysis$LATERALITY = factor(data_analysis$LATERALITY)
data_analysis$ER_STATUS = factor(data_analysis$ER_STATUS)
data_analysis$HER2_STATUS = factor(data_analysis$HER2_STATUS)
data_analysis$TUMOR_STAGE = factor(data_analysis$TUMOR_STAGE)

# 缺失值概览
table(is.na(data_analysis$TreatmentOutcome))
table(is.na(data_analysis$AGE_AT_DIAGNOSIS))
table(is.na(data_analysis$LATERALITY))
table(is.na(data_analysis$ER_STATUS))
table(is.na(data_analysis$HER2_STATUS))
table(is.na(data_analysis$TUMOR_STAGE))

# 分组描述
dataTemp <- data_analysis[data_analysis$TreatmentOutcome == 0, ]
## 连续型变量描述
mean(dataTemp$AGE_AT_DIAGNOSIS)
sd(dataTemp$AGE_AT_DIAGNOSIS)
quantile(dataTemp$AGE_AT_DIAGNOSIS)
## 分类变量描述
table(dataTemp$TUMOR_STAGE, useNA = "ifany")

dataTemp_ <- data_analysis[data_analysis$TreatmentOutcome == 1, ]
## 连续型变量描述
mean(dataTemp_$AGE_AT_DIAGNOSIS)
sd(dataTemp_$AGE_AT_DIAGNOSIS)
quantile(dataTemp_$AGE_AT_DIAGNOSIS)
## 分类变量描述
table(dataTemp_$TUMOR_STAGE, useNA = "ifany")
