# 数据导入
library(tidyverse)
library(rms)
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

# 只保留建模需要的变量
data_nom <- data_analysis %>%
  select(
    TreatmentOutcome,
    AGE_AT_DIAGNOSIS,
    ER_STATUS,
    HER2_STATUS,
    TUMOR_STAGE
  ) %>%
  drop_na()  # 显式去除缺失

# 拟合logistic模型（rms::lrm）
dd <- datadist(data_nom)
options(datadist = "dd")

fit_lrm <- lrm(
  TreatmentOutcome ~ AGE_AT_DIAGNOSIS + ER_STATUS + HER2_STATUS + TUMOR_STAGE,
  data = data_nom,
  x = TRUE, y = TRUE
)

print(fit_lrm)

# 绘制nomogram
nom <- nomogram(
  fit_lrm,
  fun = plogis,                  # 线性预测值 -> 概率
  fun.at = seq(0.1, 0.9, by = 0.1), # 概率刻度
  funlabel = "Pr(TreatmentOutcome = 1)", # 终点标签
  lp = FALSE
)

# 画图
plot(
  nom,
  xfrac = 0.45,       # 左右布局比例，可按需调
  cex.var = 1.0,
  cex.axis = 0.8,
  lmgp = 0.25
)
