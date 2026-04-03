# 数据导入
data <- read.csv("./data/metabric_cleaned_1500.csv")

# 核心变量选择
data_analysis <- data.frame(TreatmentOutcome = data$TreatmentOutcome,
                            AGE_AT_DIAGNOSIS = data$AGE_AT_DIAGNOSIS,
                            LATERALITY = data$LATERALITY,
                            ER_STATUS = data$ER_STATUS,
                            HER2_STATUS = data$HER2_STATUS,
                            TUMOR_STAGE = data$TUMOR_STAGE)
