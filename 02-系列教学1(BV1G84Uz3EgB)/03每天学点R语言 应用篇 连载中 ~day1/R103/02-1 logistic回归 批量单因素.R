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
# 分类变量转换为factor
data_analysis$TreatmentOutcome = factor(data_analysis$TreatmentOutcome)
data_analysis$LATERALITY = factor(data_analysis$LATERALITY)
data_analysis$ER_STATUS = factor(data_analysis$ER_STATUS)
data_analysis$HER2_STATUS = factor(data_analysis$HER2_STATUS)
data_analysis$TUMOR_STAGE = factor(data_analysis$TUMOR_STAGE)

# 单因素分析
## 广义线性模型分析
model_logistic <- glm(data_analysis$TreatmentOutcome ~ data_analysis$AGE_AT_DIAGNOSIS, family = binomial())
## 计算OR值
OR_value <- exp(model_logistic[["coefficients"]][["data_analysis$AGE_AT_DIAGNOSIS"]])
## 等效于OR_value <- exp(model_logistic[["coefficients"]][2])
## 计算estimate的置信区间
confint(model_logistic)
## 计算OR值的置信区间
OR_CI <- exp(confint(model_logistic)[2, ])


OR <- c(); OR_LCI = c(); OR_UCI = c(); P <- c()
# 批量建模
## 循环
for (i in 3:7) {
  data_x <- data_analysis[,i] # 需要先转换成向量
  model_logistic <- glm(data_analysis$TreatmentOutcome ~ data_x, family = binomial())
  ## 计算OR值
  OR[i-2] <- exp(model_logistic[["coefficients"]][2])
  ## 计算estimate的置信区间
  confint(model_logistic)
  ## 计算OR值的置信区间
  OR_LCI[i-2] <- exp(confint(model_logistic)[2, ][1])
  OR_UCI[i-2] <- exp(confint(model_logistic)[2, ][2])
  ## 获取P值
  P[i-2] <- summary(model_logistic)$coefficients[2, 4]
}
results <- data.frame(Variable = colnames(data_analysis)[3:7],
                      OR, OR_LCI, OR_UCI, P)

## 函数定义
OR_ <- c(); OR_LCI_ = c(); OR_UCI_ = c(); P_ <- c()
### 首先，定义一个函数
model_logistic_func <- function(data, idx) {
  data_x <- data[,idx] # 转换成向量
  model_logistic <- glm(data$TreatmentOutcome ~ data_x, family = binomial())
  OR_[idx-2] <<- exp(model_logistic[["coefficients"]][2]) # 计算OR值
  confint(model_logistic) # 计算estimate的置信区间
  OR_LCI_[idx-2] <<- exp(confint(model_logistic)[2, ][1]) # 计算OR值的置信区间下界
  OR_UCI_[idx-2] <<- exp(confint(model_logistic)[2, ][2]) # 计算OR值的置信区间上届
  P_[idx-2] <<- summary(model_logistic)$coefficients[2, 4] # 计算P值
}

### 接下来，循环调用
for (i in 3:7) {
  model_logistic_func(data_analysis, i)
}
results_func <- data.frame(Variable = colnames(data_analysis)[3:7],
                           OR_, OR_LCI_, OR_UCI_, P_)
